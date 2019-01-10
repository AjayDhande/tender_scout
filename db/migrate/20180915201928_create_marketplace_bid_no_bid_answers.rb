class CreateMarketplaceBidNoBidAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_bid_no_bid_answers do |t|
      t.text :answer_text
      t.integer :position
      t.references :bid_no_bid_question#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_bid_no_bid_answers, :marketplace_bid_no_bid_questions, column: :bid_no_bid_question_id
  end
end
