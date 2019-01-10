class AddRoleToMarketplaceTenderCollaborator < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_collaborators, :role, :integer
  end
end
