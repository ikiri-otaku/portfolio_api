class UserTech < ApplicationRecord
  belongs_to :user
  belongs_to :tech

  validates :user_id, uniqueness: { scope: :tech_id }
  validates :exp_months_job, numericality: { in: 0..99 }, allow_nil: true
  validates :exp_months_hobby, numericality: { in: 0..99 }, allow_nil: true
end
