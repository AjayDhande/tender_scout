FactoryBot.define do
  factory :marketplace_tender_award_criteria_section, class: 'Marketplace::TenderAwardCriteriaSection' do
    order { 1 }
    title { "MyString" }
    tender { nil }
  end
end
