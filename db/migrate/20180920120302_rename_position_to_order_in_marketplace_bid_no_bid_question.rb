class RenamePositionToOrderInMarketplaceBidNoBidQuestion < ActiveRecord::Migration[5.1]
  def change
    rename_column :marketplace_bid_no_bid_questions, :position, :order
  end
end
