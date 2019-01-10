class Marketplace::TenderAwardCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :collaboration_id
  has_many :award_criteries, serializer: Marketplace::TenderAwardCriteriumSerializer
end
