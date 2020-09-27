FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            {"田中"}
    family_name           {"太郎"}
    ja_first_name         {"タナカ"}
    ja_family_name        {"タロウ"}
    birth                 {Faker::Date.between(from: '1930-01-01', to: '2020-08-31')}
  end
end