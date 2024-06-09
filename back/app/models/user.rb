class User < ApplicationRecord
  before_destroy :check_organizations
  before_destroy :handle_portfolios

  has_many :organization_users, dependent: :destroy
  has_many :organizations, through: :organization_users
  has_many :user_teches, dependent: :destroy
  has_many :teches, through: :user_teches

  has_many :portfolios, dependent: :nullify

  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true
  validates :auth0_id, presence: true

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

  def handle_portfolios
    portfolios.each do |portfolio|
      if portfolio.organization.present?
        portfolio.update(user_id: nil)
      else
        portfolio.destroy
      end
    end
  end
end
