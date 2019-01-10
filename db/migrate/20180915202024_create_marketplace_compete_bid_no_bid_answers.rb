class CreateMarketplaceCompeteBidNoBidAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :marketplace_compete_bid_no_bid_answers do |t|
      t.text :answer_text
      t.references :bid_no_bid_answer, index: { name: 'index_compete_bnb_answers_on_bnb_answer' }#, foreign_key: true
      t.text :comment
      t.references :bid_no_bid_question, index: { name: 'index_compete_bnb_answers_on_bnb_question' }#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :marketplace_compete_bid_no_bid_answers, :marketplace_bid_no_bid_answers, column: :bid_no_bid_answer_id, name: 'index_compete_bnb_answers_on_bnb_answer'
    add_foreign_key :marketplace_compete_bid_no_bid_answers, :marketplace_bid_no_bid_questions, column: :bid_no_bid_question_id, name: 'index_compete_bnb_answers_on_bnb_question'
  end
end
