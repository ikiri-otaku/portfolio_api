FactoryBot.define do
  factory :organization do
    sequence :name, 'organization_1'
    sequence :github_username, 'github_username_1'

    after(:build) do |organization|
      organization.organization_users << FactoryBot.build(:organization_user, organization:, user: FactoryBot.build(:user))
    end
  end
end
