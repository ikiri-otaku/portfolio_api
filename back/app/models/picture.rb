class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :object_key, length: { maximum: 255 }
end
