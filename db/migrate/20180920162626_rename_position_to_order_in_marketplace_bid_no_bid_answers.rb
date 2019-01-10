class RenamePositionToOrderInMarketplaceBidNoBidAnswers < ActiveRecord::Migration[5.1]
  def change
    rename_column :marketplace_bid_no_bid_answers, :position, :order
  end
end
