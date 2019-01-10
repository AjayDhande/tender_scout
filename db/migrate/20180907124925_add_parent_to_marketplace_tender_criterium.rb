class AddParentToMarketplaceTenderCriterium < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_criteria, :parent
  end
end
