class RenameTenderCriteriaAnwerToTenderAwardCriteriaAnswer < ActiveRecord::Migration[5.1]
  def change
    rename_column :tender_criteria_answers, :tender_criteria_id, :tender_award_criteria_id
    rename_table :tender_criteria_answers, :tender_award_criteria_answers
  end
end
