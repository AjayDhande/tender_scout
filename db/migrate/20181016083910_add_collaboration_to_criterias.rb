class AddCollaborationToCriterias < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_award_criteria_sections, :collaboration, index: {name: 'mtac_collaboration'}
    add_reference :marketplace_tender_qualification_criteria_sections, :collaboration, index: {name: 'mtqc_collaboration'}

    add_foreign_key :marketplace_tender_award_criteria_sections, :marketplace_collaborations, column: :collaboration_id
    add_foreign_key :marketplace_tender_qualification_criteria_sections, :marketplace_collaborations, column: :collaboration_id
  end
end
