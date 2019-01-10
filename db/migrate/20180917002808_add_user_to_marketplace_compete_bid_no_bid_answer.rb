class AddUserToMarketplaceCompeteBidNoBidAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_compete_bid_no_bid_answers, :user, foreign_key: true
  end
end
