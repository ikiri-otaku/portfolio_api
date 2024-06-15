class Organization < ApplicationRecord
  before_destroy :nullify_portfolio_organization_id

  has_many :organization_users, dependent: :destroy
  has_many :users, through: :organization_users
  has_many :portfolios, dependent: :nullify

  validates :name, presence: true, length: { maximum: 50 }
  validates :github_username, length: { maximum: 50 }, uniqueness: true

  private

  def nullify_portfolio_organization_id
    portfolios.each do |portfolio|
      portfolio.update(organization_id: nil)
    end
  end
end
