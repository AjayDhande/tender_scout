class Marketplace::TenderAwardCriteriaSection < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :award_criteries, class_name: 'Marketplace::TenderAwardCriterium', foreign_key: :section_id, dependent: :destroy
end
