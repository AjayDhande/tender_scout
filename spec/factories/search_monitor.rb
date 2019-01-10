# factories for search monitor
FactoryBot.define do
  factory :search_monitor do
    user
    title         { Faker::Pokemon.name }
  end

end