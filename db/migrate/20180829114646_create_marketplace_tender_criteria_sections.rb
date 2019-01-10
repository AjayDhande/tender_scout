class CreateMarketplaceTenderCriteriaSections < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_criteria_sections do |t|
      t.integer :order
      t.string :title
      t.references :tender

      t.timestamps
    end
    add_foreign_key :marketplace_tender_criteria_sections, :core_tenders, column: :tender_id
  end
end