FactoryBot.define do
  factory :organization do
    sequence :name, 'organization_1'
    sequence :github_username, 'github_username_1'

    trait :with_user do
      after(:create) do |organization|
        organization.users << FactoryBot.create(:user) if organization.organization_users.blank?
      end
    end
  end
end
