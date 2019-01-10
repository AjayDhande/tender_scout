FactoryBot.define do
  factory :country, class: Core::Country do

    currency
    code { '376' }
    number { '020' }
    alpha2code { 'AD' }
    alpha3code { 'AND' }
    name { 'Andorra' }
    world_region { 'Europe' }
    world_subregion { 'Southern Europe' }
  end

end