class AddWeightToMarketplaceTenderAwardCriterium < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_award_criteria, :weight, :integer
  end
end
