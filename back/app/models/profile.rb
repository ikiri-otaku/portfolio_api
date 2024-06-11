class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  validates :location, length: { maximum: 255 }
  validates :company, length: { maximum: 255 }
  validates :work_location, length: { maximum: 255 }
  validates :x_username, uniqueness: true, length: { maximum: 50 }
  validates :zenn_username, uniqueness: true, length: { maximum: 50 }
  validates :qiita_username, uniqueness: true, length: { maximum: 50 }
  validates :atcoder_username, uniqueness: true, length: { maximum: 50 }
end
