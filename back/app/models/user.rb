class User < ApplicationRecord
  before_destroy :check_organizations

  has_many :organization_users, dependent: :destroy
  has_many :organizations, through: :organization_users
  has_many :portfolios, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true

  private

  def check_organizations
    organizations.each do |organization|
      if organization.users.where.not(id:).exists?
        organization_users.where(organization:).destroy_all
      else
        organization.destroy
      end
    end
  end
end
