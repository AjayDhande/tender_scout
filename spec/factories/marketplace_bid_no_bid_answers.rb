FactoryBot.define do
  factory :marketplace_bid_no_bid_answer, class: 'Marketplace::BidNoBidAnswer' do
    answer_text { "MyText" }
    position { 1 }
    bid_no_bid_question { nil }
  end
end
