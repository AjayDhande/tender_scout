class Marketplace::TenderAwardCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description, :weight, :deadline, :profile
  has_many :answers, serializer: Marketplace::TenderAwardCriteriumAnswerSerializer
  has_many :attachments
end
