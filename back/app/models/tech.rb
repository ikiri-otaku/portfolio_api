class Tech < ApplicationRecord
  belongs_to :parent, class_name: "Tech", optional: true
  has_many :children, class_name: "Tech", foreign_key: "parent_id", dependent: :nullify

  validates :name, presence: true, length: { maximum: 20 }
end
