FactoryBot.define do
  factory :marketplace_bid_no_bid_question, class: 'Marketplace::BidNoBidQuestion' do
    question_text { "MyText" }
    position { 1 }
    tender { nil }
  end
end
