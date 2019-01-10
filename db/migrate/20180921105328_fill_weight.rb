class FillWeight < ActiveRecord::Migration[5.1]
  def up
    Marketplace::BidNoBidAnswer.all.each { |e| e.update_attribute :weight, e.order }
  end
end
