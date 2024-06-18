class Portfolio < ApplicationRecord
  before_destroy :check_user_dependency

  attr_accessor :tech_names

  belongs_to :user, optional: true
  belongs_to :organization, optional: true
  has_one :github_repository, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']) }
  validates :unhealthy_cnt, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 0 }

  def github_url
    if github_repository
      "#{ENV['GITHUB_DOMAIN']}/#{github_repository.owner}/#{github_repository.repo}"
    end
  end

  def github_url=(url)
    # NOTE: 一度設定したら変更不可
    return if github_repository || url.blank?

    repo_info = GithubClient.get_owner_and_repo(url)
    unless repo_info
      self.errors.add(:github_url, I18n.t('errors.messages.repository_top'))
      raise ActiveRecord::RecordInvalid.new(self)
    end

    build_github_repository(owner: repo_info[0], repo: repo_info[1])
  end

  def check_repo_owner?(user)
    return true if github_repository.blank? || !github_repository.changed?

    github_client = GithubClient.new
    if user.github_username == github_repository.owner
      github_client.repository_exists?(github_repository.owner, github_repository.repo)
    else
      github_client.collaborator?(github_repository.owner, github_repository.repo, user.github_username)
    end
  end

  def health_check
    health_check_client = HealthCheckClient.new(self)
    if health_check_client.check?
      self.unhealthy_cnt = 0
    else
      self.unhealthy_cnt += 1
    end
    self.latest_health_check_time = Time.current
  end

  def save_associations! # rubocop:disable Metrics/AbcSize
    ActiveRecord::Base.transaction do
      if github_repository&.changed? && (user.github_username != github_repository.owner)
        # Organization作成
        self.organization = Organization.find_by(github_username: github_repository.owner) || Organization.new(name: github_repository.owner, github_username: github_repository.owner)
        user.organizations << organization unless user.organizations.include?(organization)
      end
      # TODO: PortfolioTech保存
      save!
    end
  end

  private

  def check_user_dependency
    throw(:abort) if organization.present?
  end
end
