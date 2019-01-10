class CreateMarketplaceUserTenderStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_user_tender_statuses do |t|
      t.integer :user_id
      t.integer :tender_id
      t.integer :collaboration_id
      t.integer :status, default: 0
    end
  end
end
