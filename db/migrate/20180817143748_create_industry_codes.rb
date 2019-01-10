class CreateIndustryCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :industry_codes do |t|
      t.string :entity_code_name, null: false, default: ''
      t.integer :entity_code_id, null: false, default: 0
      t.references :industry, foreign_key: true
    end
  end
end
