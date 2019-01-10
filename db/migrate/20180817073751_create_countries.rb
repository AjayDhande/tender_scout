class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :code, null: false, default: ''
      t.string :number, null: false, default: ''
      t.string :alpha2code, null: false, default: ''
      t.string :alpha3code, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :world_region, null: false, default: ''
      t.string :world_subregion, null: false, default: ''
      t.string  :other_names, null: false
      t.references :currencies, foreign_key: true
      t.references :world_regions, foreign_key: true
    end

    add_index :countries, :code, unique: true
    add_index :countries, :number
    add_index :countries, :alpha2code, unique: true
    add_index :countries, :alpha3code, unique: true
    add_index :countries, :name
  end
end
