class AllowNullInContactFields < ActiveRecord::Migration[5.1]
  def change
    change_column :core_contacts, :organization_id, :integer, :null => true
  end
end
