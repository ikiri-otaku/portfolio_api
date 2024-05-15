FactoryBot.define do
  factory :portfolio do
    sequence :name, 'portfolio_1'
    sequence :url, 'url_1'
    introduction { "This is a sample portfolio introduction." }
    unhealthy_cnt { 0 }
    latest_health_check_time { Time.now }

    association :user
    association :organization

    trait :with_user do
      after(:create) do |portfolio|
        portfolio.users << FactoryBot.create(:user)
      end
    end

    trait :with_organization do
      after(:create) do |portfolio|
        portfolio.organization = FactoryBot.create(:organization)
      end
    end
  end
end
