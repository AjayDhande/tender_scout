class AddTenderToTenderMarketplaceEntities < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_tasks, :tender
    add_reference :marketplace_tender_criteria, :tender

    add_foreign_key :marketplace_tender_tasks, :core_tenders, column: :tender_id
    add_foreign_key :marketplace_tender_criteria, :core_tenders, column: :tender_id
  end
end
