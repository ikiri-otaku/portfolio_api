FactoryBot.define do
  factory :user do
    sequence :name, 'user_1'
    sequence :github_username, 'github_username_1'
    sequence :auth0_id, 'auth0|00000001'

    trait :with_tech do
      after(:create) do |user|
        user.teches << FactoryBot.create(:tech) if user.teches.blank?
      end
    end
  end
end
