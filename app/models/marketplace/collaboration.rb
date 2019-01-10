class Marketplace::Collaboration < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :tender_collaborators, class_name: 'Marketplace::TenderCollaborator', dependent: :destroy
  has_many :users, through: :tender_collaborators
  has_many :assignments, class_name: 'Marketplace::Assignment'
  has_many :tender_qualification_criteria_answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer'
  has_many :tender_award_criteria_answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer'
  has_many :marketplace_bid_results, class_name: 'Marketplace::BidResult', foreign_key: :marketplace_collaboration_id
end
