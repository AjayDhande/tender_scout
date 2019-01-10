class Marketplace::TenderCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description, :parent_id, :weight
#  has_many :subcriterias, serializer: Marketplace::TenderCriteriumSerializer
end
