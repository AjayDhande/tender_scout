class RefactorTenderCollaborators < ActiveRecord::Migration[5.1]
  def change
    rename_column :marketplace_tender_collaborators, :tender_id, :collaboration_id
    remove_foreign_key :marketplace_tender_collaborators, :core_tenders
  end
end
