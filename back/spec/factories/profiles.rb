FactoryBot.define do
  factory :profile do
    association :user
    sequence :x_username, 'x_username_1'
    sequence :zenn_username, 'zenn_username_1'
    sequence :qiita_username, 'qiita_username_1'
    sequence :atcoder_username, 'atcoder_username_1'
  end
end
