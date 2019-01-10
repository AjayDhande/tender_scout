class ChangeStatusTypeInSuppliers < ActiveRecord::Migration[5.1]
  def change
    remove_column :suppliers, :status
    add_column :suppliers, :status, :integer, default: :pending
  end
end
