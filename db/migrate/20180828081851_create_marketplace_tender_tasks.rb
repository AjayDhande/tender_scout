class CreateMarketplaceTenderTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_tender_tasks do |t|
      t.integer :order
      t.string :title
      t.float :weight

      t.timestamps
    end
  end
end
