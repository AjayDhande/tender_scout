# factories for user
FactoryBot.define do
  factory :user do
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    role          { :free }
    confirmed_at  { DateTime.now }
  end

  factory :admin do
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    role          { :admin }
    confirmed_at  { DateTime.now }
  end

end