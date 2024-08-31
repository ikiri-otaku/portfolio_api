FactoryBot.define do
  factory :bookmark do
    association :portfolio
    association :user
  end
end
