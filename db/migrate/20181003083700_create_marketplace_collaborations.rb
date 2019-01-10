class CreateMarketplaceCollaborations < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_collaborations do |t|
      t.references :tender
      t.timestamps
    end
    add_foreign_key :marketplace_collaborations, :core_tenders, column: :tender_id

  end
end
