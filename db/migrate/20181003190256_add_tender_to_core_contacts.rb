class AddTenderToCoreContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :core_contacts, :tender
    add_foreign_key :core_contacts, :core_tenders, column: :tender_id
  end
end
