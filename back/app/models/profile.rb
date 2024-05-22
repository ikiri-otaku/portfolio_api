class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  validates :x_username, uniqueness: true, length: { maximum: 50 }
  validates :zenn_url, uniqueness: true, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/ }
  validates :qiita_url, uniqueness: true, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/ }
  validates :atcoder_username, uniqueness: true, length: { maximum: 50 }
end
