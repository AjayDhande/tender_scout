class Marketplace::TenderCriteriaSection < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :criteries, class_name: 'Marketplace::TenderCriterium', foreign_key: :section_id, dependent: :destroy
end
