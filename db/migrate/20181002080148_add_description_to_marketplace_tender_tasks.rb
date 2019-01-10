class AddDescriptionToMarketplaceTenderTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_tasks, :description, :text
  end
end
