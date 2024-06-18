FactoryBot.define do
  factory :github_repository do
    association :portfolio
    sequence :owner, 'owner_1'
    sequence :repo, 'repo_1'
  end
end
