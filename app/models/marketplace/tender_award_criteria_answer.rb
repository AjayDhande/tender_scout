class Marketplace::TenderAwardCriteriaAnswer < ApplicationRecord
  after_save :update_bidstatus
  belongs_to :award_criteria, class_name: 'Marketplace::TenderAwardCriterium', foreign_key: :tender_award_criteria_id
  belongs_to :user
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration', foreign_key: :collaboration_id
  #validations
  validates :collaboration_id, presence: true

  def update_bidstatus
    score =  self.score
    collaboration = self.collaboration_id
    criteria = self.tender_award_criteria_id
    answer_id = self.id
    bid_result = Marketplace::BidResult.find_or_initialize_by(marketplace_collaboration_id: collaboration,
                                                               tender_award_criteria_id: criteria)
      bid_result.estimate_score = score
      bid_result.award_criteria_answer_id = answer_id
      bid_result.save
  end
end
