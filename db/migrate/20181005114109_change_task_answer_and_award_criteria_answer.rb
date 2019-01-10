class ChangeTaskAnswerAndAwardCriteriaAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_index :tender_award_criteria_answers, ["tender_award_criteria_id"]
    add_index :tender_award_criteria_answers, ["tender_award_criteria_id"], name: 'tender_award_criteria_answers_index'
    rename_table :tender_award_criteria_answers, :marketplace_tender_award_criteria_answers
    rename_table :tender_task_answers, :marketplace_tender_task_answers
  end
end
