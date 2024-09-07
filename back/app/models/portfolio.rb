class Portfolio < ApplicationRecord
  attr_accessor :tech_names

  belongs_to :user, optional: true
  belongs_to :organization, optional: true
  has_many :portfolio_teches, dependent: :destroy
  has_many :teches, through: :portfolio_teches
  has_one :github_repository, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']) }
  validates :unhealthy_cnt, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 0 }

  def github_url
    return unless github_repository

    "#{ENV.fetch('GITHUB_DOMAIN', nil)}/#{github_repository.owner}/#{github_repository.repo}"
  end

  def github_url=(url)
    # NOTE: 一度設定したら変更不可
    return if url.blank?

    repo_info = GithubClient.get_owner_and_repo(url)
    unless repo_info
      errors.add(:github_url, I18n.t('errors.messages.repository_top'))
      raise ActiveRecord::RecordInvalid, self
    end

    if github_repository
      github_repository.attributes = { owner: repo_info[0], repo: repo_info[1] }
    else
      build_github_repository(owner: repo_info[0], repo: repo_info[1])
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
        self.organization =
          Organization.find_by(github_username: github_repository.owner) ||
          Organization.new(name: github_repository.owner, github_username: github_repository.owner)
        user.organizations << organization unless user.organizations.include?(organization)
      end
      # TODO: PortfolioTech保存
      github_repository.save! if github_repository&.changed?
      save!
    end
  end

  def to_api_response
    {
      id:,
      name:,
      url:,
      introduction:,
      created_date: created_at.strftime('%Y/%m/%d'),
      creator: organization&.name || user&.name
    }
  end
end
