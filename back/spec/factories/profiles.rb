FactoryBot.define do
  factory :profile do
    association :user
    sequence :x_username, 'x_username_1'
    sequence :zenn_url, 'https://zenn.dev/example_1'
    sequence :qiita_url, 'https://qiita.com/example_1'
    sequence :atcoder_username, 'atcoder_username_1'
  end
end
