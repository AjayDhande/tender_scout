  FactoryBot.define do

    factory :currency, class: Core::Currency do
      name { 'Dirhams' }
      code { Faker::Currency.code }
      unit { '' }
    end

  end