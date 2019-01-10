class AddValuesFieldsToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :valueFrom, :integer, null: false, default: 0
    add_column :profiles, :valueTo, :integer, null: false, default: 0
    add_column :profiles, :tender_level, :integer, null: false, default: 0
    add_column :profiles, :number_public_contracts, :integer, null: false, default: 0
  end
end
