class CreateMarketplaceAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_assignments do |t|
      t.string :assignable_type
      t.integer :assignable_id
      t.integer :user_id
      t.string :collaboration_id

      t.timestamps
    end
  end
end
