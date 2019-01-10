class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :name, null: false, default: ''
      t.string :code, null: false, default: ''
      t.string :unit, null: true
    end

    add_index :currencies, :name
    add_index :currencies, :code
  end
end
