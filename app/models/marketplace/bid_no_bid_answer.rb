class Marketplace::BidNoBidAnswer < ApplicationRecord
  belongs_to :bid_no_bid_question
  has_many :bid_no_bid_answers, class_name: 'Marketplace::Compete::BidNoBidAnswer', dependent: :destroy
end
