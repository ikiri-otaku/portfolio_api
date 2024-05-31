class User < ApplicationRecord
  after_destroy :destroy_organizations_if_no_users

  has_many :organization_users, dependent: :destroy
  has_many :organizations, through: :organization_users
  has_many :portfolios, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true

  private

  def destroy_organizations_if_no_users
    organizations.each do |organization|
      organization.destroy if organization.users.reload.empty?
    end
  end
end
