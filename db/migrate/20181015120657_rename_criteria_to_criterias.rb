class RenameCriteriaToCriterias < ActiveRecord::Migration[5.1]
  def change
    rename_table :marketplace_tender_qualification_criterias, :marketplace_tender_qualification_criteria
  end
end
