FactoryBot.define do
  factory :user do
    first_name "Jan"
    last_name "Kowalski"
    sequence(:login) { |n| "login#{n}"}
    sequence(:email) { |n| "mail#{n}@example.com"}
    password "password123"
  end
end
