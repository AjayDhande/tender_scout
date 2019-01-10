class Marketplace::TenderAwardCriterium < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderAwardCriteriaSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer', foreign_key: :tender_award_criteria_id, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notes, as: :notable, dependent: :destroy
  has_many :assignments, class_name: 'Marketplace::Assignment', as: :assignable, dependent: :destroy
  has_many :marketplace_bid_results, class_name: 'Marketplace::BidResult', foreign_key: :tender_award_criteria_id

  has_and_belongs_to_many :attachments, class_name: 'Attachment'

  include Assignable
end
