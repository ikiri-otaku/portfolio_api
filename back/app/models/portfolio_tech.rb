class PortfolioTech < ApplicationRecord
  belongs_to :portfolio
  belongs_to :tech

  validates :portfolio_id, uniqueness: { scope: :tech_id }
end
