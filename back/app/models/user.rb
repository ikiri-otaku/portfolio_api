class User < ApplicationRecord
  has_many :organization_users, dependent: :destroy
  has_many :organizations, through: :organization_users
  has_one :profile, dependent: :destroy
  has_many :user_teches, dependent: :destroy
  has_many :teches, through: :user_teches
  has_many :portfolios, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :favolits, through: :likes, source: :portfolios

  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true
  validates :auth0_id, presence: true
end
