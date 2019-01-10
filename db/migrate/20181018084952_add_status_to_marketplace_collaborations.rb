class AddStatusToMarketplaceCollaborations < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_collaborations, :status, :integer
  end
end
