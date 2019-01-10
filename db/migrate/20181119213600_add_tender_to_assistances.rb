class AddTenderToAssistances < ActiveRecord::Migration[5.1]
  def change
    add_reference :assistances, :tender
    add_foreign_key :assistances, :core_tenders, column: :tender_id	
  end
end
