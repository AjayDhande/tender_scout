class Marketplace::TenderQualificationCriteriaSection < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :qualification_criterias, class_name: 'Marketplace::TenderQualificationCriteria', foreign_key: :section_id, dependent: :destroy
end
