class AddFilesToMarketplaceTenderAwardCriteria < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_award_criteria, :files, :json
  end
end
