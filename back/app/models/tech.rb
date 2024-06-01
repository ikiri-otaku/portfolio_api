class Tech < ApplicationRecord
  include Discard::Model

  belongs_to :parent, class_name: "Tech", optional: true, inverse_of: :children
  has_many :children, class_name: "Tech", foreign_key: "parent_id", dependent: :nullify, inverse_of: :parent

  validates :name, presence: true, length: { maximum: 20 }
end
