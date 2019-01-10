class Marketplace::BidResult < ApplicationRecord
  belongs_to :marketplace_collaboration, :class_name => 'Marketplace::Collaboration', foreign_key: :marketplace_collaboration_id
  belongs_to :award_criteria, class_name: 'Marketplace::TenderAwardCriterium', foreign_key: :tender_award_criteria_id
end
