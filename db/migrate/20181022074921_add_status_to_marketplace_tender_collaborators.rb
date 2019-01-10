class AddStatusToMarketplaceTenderCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_collaborators, :status, :integer
  end
end
