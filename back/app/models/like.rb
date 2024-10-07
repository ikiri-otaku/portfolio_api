class Like < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :portfolio

  validates :user_id, uniqueness: { scope: :portfolio_id }
end
