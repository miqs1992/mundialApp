FactoryBot.define do
  factory :match do
    association :team1, factory: :team
    association :team2, factory: :team
    city {Faker::Address.city}
    start_time Time.current
    match_day
  end
end
