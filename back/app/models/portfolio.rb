class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :unhealthy_cnt, numericality: { only_integer: true, less_than_or_equal_to: 4 }
  
  before_destroy :check_user_dependency

  private

  def check_user_dependency
    throw(:abort) if organization.present?
  end
end
