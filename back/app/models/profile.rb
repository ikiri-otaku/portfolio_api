class Profile < ApplicationRecord
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :user_id, uniqueness: true
  validates :location, length: { maximum: 255 }
  validates :hireable, inclusion: { in: [true, false] }
  validates :company, length: { maximum: 255 }
  validates :work_location, length: { maximum: 255 }
  validates :x_username, uniqueness: true, length: { maximum: 50 }
  validates :zenn_username, uniqueness: true, length: { maximum: 50 }
  validates :qiita_username, uniqueness: true, length: { maximum: 50 }
  validates :atcoder_username, uniqueness: true, length: { maximum: 50 }
end
