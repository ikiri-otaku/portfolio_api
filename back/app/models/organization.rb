class Organization < ApplicationRecord
  before_destroy :ensure_no_users

  has_many :organization_users, dependent: :destroy
  has_many :users, through: :organization_users
  has_many :portfolios, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true

  private

  def ensure_no_users
    throw(:abort) if users.exists?
  end
end
