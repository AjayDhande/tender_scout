#create factorie for tender
FactoryBot.define do
  factory :tender, class: Core::Tender do
    user
    country
    title { Faker::Name.name }
    description { Faker::Lorem.sentences(1) }
    created_at { DateTime.now }
    low_value { 1 }
    high_value { 100 }
  end

end