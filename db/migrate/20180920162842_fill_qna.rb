class FillQna < ActiveRecord::Migration[5.1]
  def up
    Marketplace::BidNoBidQuestion.destroy_all
    (1..8).each {|e| Marketplace::BidNoBidQuestion.create(question_text: "Question #{e}", order: e) }
    Marketplace::BidNoBidAnswer.destroy_all
    Marketplace::BidNoBidQuestion.all.each_with_index { |e, i| (1..5).each { |f| e.bid_no_bid_answers.create(answer_text: "Answer #{i}-#{f}", order: f) } }
  end
end
