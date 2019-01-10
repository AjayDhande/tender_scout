class CreateMarketplaceTenderCommittees < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_committees do |t|
      t.references :tender#, foreign_key: true
      t.references :user#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_tender_committees, :core_tenders, column: :tender_id
  end
end
