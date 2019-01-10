class Marketplace::TenderQualificationCriteria < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderQualificationCriteriaSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer', foreign_key: :tender_qualification_criteria_id, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :notes, as: :notable
  has_many :assignments, class_name: 'Marketplace::Assignment', as: :assignable
  has_and_belongs_to_many :attachments
  include Assignable
end
