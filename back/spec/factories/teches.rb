FactoryBot.define do
  factory :tech do
    sequence :name, 'tech_1'

    trait :with_child do
      after(:create) do |parent|
        FactoryBot.create(:tech, parent:)
      end
    end

    trait :discarded do
      discarded_at { Time.current }
    end
  end
end
