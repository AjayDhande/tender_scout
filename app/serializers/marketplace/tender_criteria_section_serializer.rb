class Marketplace::TenderCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_many :criteries, serializer: TenderCriteriumSerializer
end
