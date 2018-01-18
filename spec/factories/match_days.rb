FactoryBot.define do
  factory :match_day do
    round
    stop_bet_time Time.current
    day_number {Faker::Number.unique.between(1,50)}
  end
end
