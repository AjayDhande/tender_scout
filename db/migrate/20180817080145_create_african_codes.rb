class CreateAfricanCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :african_codes do |t|
      t.string :code, null: false, default: ''
      t.string :description, null: false, default: ''
    end

    add_index :african_codes, :code
  end
end
