FactoryBot.define do
  factory :portfolio do
    association :user
    sequence :name, 'portfolio_1'
    sequence :url, 'http://example_1.com'
    introduction { 'This is a sample portfolio introduction.' }
    unhealthy_cnt { 0 }
    latest_health_check_time { Time.current }

    trait :with_organization do
      after(:create) do |portfolio|
        organization = FactoryBot.create(:organization)
        portfolio.user.organizations << organization
        portfolio.organization = organization
        portfolio.save
      end
    end
  end
end
