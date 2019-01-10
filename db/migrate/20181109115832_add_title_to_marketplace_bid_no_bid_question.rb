class AddTitleToMarketplaceBidNoBidQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_bid_no_bid_questions, :title, :string
  end
end
