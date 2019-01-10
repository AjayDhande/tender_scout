class Marketplace::TenderCriterium < ApplicationRecord
  has_one :tender, through: :section
  belongs_to :section, class_name: 'Marketplace::TenderCriteriaSection', foreign_key: :section_id
  has_many :subcriterias, class_name: 'Marketplace::TenderCriterium', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Marketplace::TenderCriterium', optional: true
  has_many :answers, class_name: 'TenderCriteriaAnswer', foreign_key: :tender_criteria_id
end
