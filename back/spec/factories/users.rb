FactoryBot.define do
  factory :user do
    sequence :name, 'user_1'
    sequence :github_username, 'github_username_1'
  end
end
