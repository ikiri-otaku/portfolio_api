class Portfolio < ApplicationRecord
  attr_accessor :github_url, :tech_names

  belongs_to :user, optional: true
  belongs_to :organization, optional: true
  has_many :portfolio_teches, dependent: :destroy
  has_many :teches, through: :portfolio_teches

  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']) }
  validates :unhealthy_cnt, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 0 }

  def check_repo_owner?(user)
    return true if github_url.blank?

    repo_info = GithubClient.get_owner_and_repo(github_url)
    return false unless repo_info

    github_client = GithubClient.new
    if user.github_username == repo_info[0]
      github_client.repository_exists?(repo_info[0], repo_info[1])
    else
      github_client.collaborator?(repo_info[0], repo_info[1], user.github_username)
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
    repo_info = GithubClient.get_owner_and_repo(github_url)
    ActiveRecord::Base.transaction do
      if new_record? && (repo_info && user.github_username != repo_info[0])
        # Organization作成
        self.organization = Organization.find_by(github_username: repo_info[0]) || Organization.new(name: repo_info[0], github_username: repo_info[0])
        user.organizations << organization unless user.organizations.include?(organization)
      end
      # TODO: GithubRepository作成
      # TODO: PortfolioTech保存
      save!
    end
  end
end
