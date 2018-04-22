FactoryBot.define do
  factory :league do
    sequence(:name) { |n| "name#{n}" }
  end
end
