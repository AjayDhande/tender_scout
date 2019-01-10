class CreateGsinCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :gsin_codes do |t|
      t.string :code, null: false, default: ''
      t.string :description, null: false, default: ''
    end

    add_index :gsin_codes, :code
  end
end
