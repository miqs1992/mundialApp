FactoryBot.define do
  factory :player do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.first_name}
    number {Faker::Number.unique.number(6)}
    team
  end
end
