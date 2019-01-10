class AddTenderToMarketplaceCompeteBidNoBidAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_compete_bid_no_bid_answers, :tender#, foreign_key: true
    add_foreign_key :marketplace_compete_bid_no_bid_answers, :core_tenders, column: :tender_id
  end
end
