class ChangeFkRelation < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :marketplace_tender_award_criteria_answers, column: :tender_award_criteria_id
    add_foreign_key :marketplace_tender_award_criteria_answers, :marketplace_tender_award_criteria, column: :tender_award_criteria_id
  end
end
