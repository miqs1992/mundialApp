FactoryBot.define do
  factory :player do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.first_name}
    team
  end
end
