class Marketplace::Compete::BidNoBidAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer_text, :comment, :bid_no_bid_question_id, :created_at, :order, :weight
  has_one :bid_no_bid_answer
  has_one :bid_no_bid_question

  def order
    object.try(:bid_no_bid_answer).try(:order)
  end

  def weight
    object.try(:bid_no_bid_answer).try(:weight)
  end
end
