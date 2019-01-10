class CreateMarketplaceTenderAwardCriteria < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_award_criteria do |t|
      t.integer :order
      t.string :title
      t.text :description
      t.references :section#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_tender_award_criteria, :marketplace_tender_award_criteria_sections, column: :section_id
  end
end
