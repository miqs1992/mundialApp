FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "name#{n}" }
    sequence(:flag) { |n| "fl#{n}" }
  end
end
