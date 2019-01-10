class CreateNigpCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nigp_codes do |t|
      t.string :code, null: false, default: ''
      t.string :description, null: false, default: ''
    end

    add_index :nigp_codes, :code
  end
end
