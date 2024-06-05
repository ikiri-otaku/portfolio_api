class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  validates :x_username, uniqueness: true, length: { maximum: 50 }
  validates :zenn_url, uniqueness: true
  validates :qiita_url, uniqueness: true
  validates :atcoder_username, uniqueness: true, length: { maximum: 50 }
end
