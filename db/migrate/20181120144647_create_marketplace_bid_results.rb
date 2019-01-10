class CreateMarketplaceBidResults < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_bid_results do |t|
      t.integer :estimate_score
      t.integer :actual_score
      t.integer :winning_score
      t.integer :award_criteria_answer_id
      t.integer :tender_award_criteria_id
      t.references :marketplace_collaboration, foreign_key: true
      t.timestamps
    end
  end
end
