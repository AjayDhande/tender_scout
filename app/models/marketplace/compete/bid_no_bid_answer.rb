class Marketplace::Compete::BidNoBidAnswer < ApplicationRecord
  belongs_to :bid_no_bid_answer, class_name: 'Marketplace::BidNoBidAnswer'
  belongs_to :bid_no_bid_question
  belongs_to :tender
  belongs_to :user
end
