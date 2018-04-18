FactoryBot.define do
  factory :team do
    name { |n| "name#{n}" }
    flag { |n| "fl#{n}" }
  end
end
