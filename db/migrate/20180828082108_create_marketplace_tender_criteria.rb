class CreateMarketplaceTenderCriteria < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_criteria do |t|
      t.integer :order
      t.string :title

      t.timestamps
    end
  end
end
