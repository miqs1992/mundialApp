FactoryBot.define do
  factory :team do
    name {Faker::Address.country }
    flag {Faker::Address.country_code_long}
  end
end
