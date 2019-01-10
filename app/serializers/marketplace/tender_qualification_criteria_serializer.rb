class Marketplace::TenderQualificationCriteriaSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :weight, :description, :deadline, :tender_id, :profile
  has_many :answers
  has_many :attachments
end
