FactoryBot.define do
  factory :world_region, class: Core::WorldRegion do
    code { '376' }
    name { 'Andorra' }
  end

  factory :registration_request, class: RegistrationRequest do |t|
    industry
    country
    t.fullname      { Faker::Name.name }
    t.company       { Faker::Company.name }
    t.company_size  { 10 }
    t. state         { Faker::Address.state }
    #country       { Faker::Address.country }
    t.city          { Faker::Address.city }
    t.turnover      { 20000 }
    t.tender_level  { 2 }
    t.win_rate      { 50 }
    t.number_public_contracts { 10 }
    t.do_use_automation { false }
    t.do_use_collaboration { false }
    t.do_use_bid_no_bid { false }
    t.do_use_bid_library { false }
    t.do_use_feedback { false }
    t.do_collaborate { true }
    t.tender_complete_time { 0.5 }
    t.organisation_count { 10 }
    t.do_processed  { false }
    #t.country_id { 1 }
    #t.industry_id { 1 }
  end


end