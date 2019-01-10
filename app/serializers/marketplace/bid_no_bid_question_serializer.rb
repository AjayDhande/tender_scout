class Marketplace::BidNoBidQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_text, :title, :order
  has_one :tender
end
