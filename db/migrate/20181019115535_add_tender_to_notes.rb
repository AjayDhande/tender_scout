class AddTenderToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :tender_id, :integer
  end
end
