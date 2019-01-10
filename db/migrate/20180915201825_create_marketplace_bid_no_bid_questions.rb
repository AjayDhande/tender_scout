class CreateMarketplaceBidNoBidQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_bid_no_bid_questions do |t|
      t.text :question_text
      t.integer :position
      t.references :tender#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_bid_no_bid_questions, :core_tenders, column: :tender_id
  end
end
