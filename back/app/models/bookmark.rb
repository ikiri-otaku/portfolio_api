class Bookmark < ApplicationRecord
  belongs_to :portfolio
  belongs_to :user

  validates :portfolio_id, uniqueness: { scope: :user_id }
end
