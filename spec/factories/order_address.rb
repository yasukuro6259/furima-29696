FactoryBot.define do
  factory :order_address do
    postal_code               { "329-0433" }
    region_id                 { Faker::Number.between(from: 2, to: 48) }
    city                      { "下野市" }
    address_line              { "祇園3丁目2 ダイアパレス" }
    building_number           { "234" }
    phone_number              { "08012122223" }
    token                     { "tok_849f66894db6a27f3e9d1d42ba40" }
    user_id                   { "1" }
    item_id                   { "1" }
  end
end
