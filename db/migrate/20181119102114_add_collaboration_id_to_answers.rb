class AddCollaborationIdToAnswers < ActiveRecord::Migration[5.1]
  def up
    Marketplace::TenderAwardCriteriaAnswer.where(collaboration_id: nil).each do |answer|
      collaboration =  Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: answer.tender_id), user: answer.user_id).try(:first).try(:collaboration)
      answer.update(collaboration_id: collaboration.id) if collaboration
    end
    Marketplace::TenderQualificationCriteriaAnswer.where(collaboration_id: nil).each do |answer|
      collaboration =  Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: answer.tender_id), user: answer.user_id).try(:first).try(:collaboration)
      answer.update(collaboration_id: collaboration.id) if collaboration
    end
  end
end
