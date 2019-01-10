class Marketplace::TenderQualificationCriteriaAnswer < ApplicationRecord
  belongs_to :qualification_criteria, class_name: 'Marketplace::TenderQualificationCriteria', foreign_key: :tender_qualification_criteria_id
  belongs_to :user
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration', foreign_key: :collaboration_id
  #validations
  validates :collaboration_id, presence: true
end
