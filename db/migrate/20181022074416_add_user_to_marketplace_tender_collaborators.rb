class AddUserToMarketplaceTenderCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_collaborators, :invited_by_user#, foreign_key: true
    add_foreign_key :marketplace_tender_collaborators, :users, column: :invited_by_user_id
  end
end
