class AddDescriptionToMarketplaceTenderCriteria < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_criteria, :description, :text
  end
end
