FactoryBot.define do
  factory :bet do
    user
    match
    score1 {Faker::Number.between(0,6)}
    score2 {Faker::Number.between(0,6)}
  end
end
