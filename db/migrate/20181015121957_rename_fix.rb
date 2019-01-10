class RenameFix < ActiveRecord::Migration[5.1]
  def change
    rename_table :tender_qualification_criteria_answers, :marketplace_tender_qualification_criteria_answers
  end
end
