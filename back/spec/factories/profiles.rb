FactoryBot.define do
  factory :profile do
    association :user
    sequence :x_username, 'x_username_1'
    sequence :zenn_url, 'https://zenn.dev/example'
    sequence :qiita_url, 'https://qiita.com/example'
    sequence :atcoder_username, 'atcoder_username_1'
  end
end
