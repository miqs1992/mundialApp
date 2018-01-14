FactoryBot.define do
  factory :round do
    sequence(:title) { |n| "title#{n}"}
    score_factor 1
  end
end
