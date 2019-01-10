FactoryBot.define do
  factory :marketplace_compete_bid_no_bid_answer, class: 'Marketplace::Compete::BidNoBidAnswer' do
    answer_text { "MyText" }
    bid_no_bid_answer { nil }
    comment { "MyText" }
    bid_no_bid_question { nil }
  end
end
