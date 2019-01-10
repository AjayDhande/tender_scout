class Marketplace::TenderQualificationCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :collaboration_id
  has_many :qualification_criterias, serializer: TenderQualificationCriteriaSerializer
end
