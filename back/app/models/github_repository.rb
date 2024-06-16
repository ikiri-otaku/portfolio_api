class GithubRepository < ApplicationRecord
  belongs_to :portfolio

  validates :portfolio_id, uniqueness: true
  validates :owner, presence: true, length: { maximum: 50 }
  validates :repo, presence: true, length: { maximum: 100 }
end
