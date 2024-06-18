class GithubRepository < ApplicationRecord
  belongs_to :portfolio

  validates :portfolio_id, uniqueness: true
  validates :owner, presence: true, length: { maximum: 50 }
  validates :repo, presence: true, length: { maximum: 100 }

  def check_repo_owner?(user)
    return true unless changed?

    github_client = GithubClient.new
    if user.github_username == owner
      github_client.repository_exists?(owner, repo)
    else
      github_client.collaborator?(owner, repo, user.github_username)
    end
  end
end
