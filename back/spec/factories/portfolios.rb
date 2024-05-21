FactoryBot.define do
  factory :portfolio do
    association :user
    sequence :name, 'portfolio_1'
    sequence :url, 'http://example_1.com'
    introduction { "This is a sample portfolio introduction." }
    unhealthy_cnt { 0 }
    latest_health_check_time { Time.current }

    trait :with_organization do
      after(:create) do |portfolio|
        portfolio.organization = FactoryBot.create(:organization, user: portfolio.user)
      end
    end
  end
end
