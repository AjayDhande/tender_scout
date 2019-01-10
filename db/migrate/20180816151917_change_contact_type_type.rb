class ChangeContactTypeType < ActiveRecord::Migration[5.1]
  def change
    change_column :contacts, :contact_type, :string
  end
end
