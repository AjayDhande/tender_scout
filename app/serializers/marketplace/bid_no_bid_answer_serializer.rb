class Marketplace::BidNoBidAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer_text, :order, :weight
  has_one :bid_no_bid_question
end
