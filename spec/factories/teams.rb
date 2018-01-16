FactoryBot.define do
  factory :team do
    name {Faker::Address.unique.country }
    flag {Faker::Address.unique.country_code_long}
  end
end
