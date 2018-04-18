FactoryBot.define do
  factory :user do
    first_name 'Jan'
    last_name 'Kowalski'
    sequence(:login) { |n| "login#{n}" }
    sequence(:email) { |n| "mail#{n}@example.com" }
    password 'password123'
    top_team factory: :team
    top_player factory: :player

    trait :admin do
      admin true
    end

    trait :no_tops do
      top_team nil
      top_player nil
    end
  end
end
