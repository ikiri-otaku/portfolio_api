FactoryBot.define do
  factory :tech do
    sequence :name, 'tech_1'

    trait :with_child do
      after(:create) do |parent|
        FactoryBot.create(:tech, parent:)
      end
    end
  end
end
