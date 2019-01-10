class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :name, null: false, default: ''
    end

    add_index :keywords, :name
  end
end
