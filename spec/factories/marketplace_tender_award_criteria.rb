FactoryBot.define do
  factory :marketplace_tender_award_criterium, class: 'Marketplace::TenderAwardCriterium' do
    order { 1 }
    title { "MyString" }
    description { "MyText" }
    tender_award_criteria_section { nil }
  end
end
