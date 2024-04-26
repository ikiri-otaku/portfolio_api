class OrganizationUser < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  validates :organization, presence: true
  validates :user, presence: true
end
