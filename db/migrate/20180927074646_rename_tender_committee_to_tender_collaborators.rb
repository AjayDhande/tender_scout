class RenameTenderCommitteeToTenderCollaborators < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :marketplace_tender_committees, :core_tenders
    rename_table :marketplace_tender_committees, :marketplace_tender_collaborators
    add_foreign_key :marketplace_tender_collaborators, :core_tenders, column: :tender_id
  end
end
