class CreateMarketplaceTenderTaskSections < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_task_sections do |t|
      t.integer :order
      t.string :title
      t.references :tender#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_tender_task_sections, :core_tenders, column: :tender_id
  end
end
