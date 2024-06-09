class Portfolio < ApplicationRecord
  before_destroy :check_user_dependency

  belongs_to :user, optional: true
  belongs_to :organization, optional: true
  has_many :portfolio_teches, dependent: :destroy
  has_many :teches, through: :portfolio_teches

  validates :name, presence: true, length: { maximum: 50 }
  validates :url, presence: true,
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']) }
  validates :unhealthy_cnt, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 0 }

  private

  def check_user_dependency
    throw(:abort) if organization.present?
  end
end
