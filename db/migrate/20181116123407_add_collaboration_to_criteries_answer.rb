class AddCollaborationToCriteriesAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_award_criteria_answers, :collaboration_id, :integer
    add_column :marketplace_tender_qualification_criteria_answers, :collaboration_id, :integer
  end
end
