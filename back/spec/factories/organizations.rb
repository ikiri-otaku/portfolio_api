FactoryBot.define do
  factory :organization do
    sequence :name, 'organization_1'
    sequence :github_username, 'github_username_1'
  end
end
