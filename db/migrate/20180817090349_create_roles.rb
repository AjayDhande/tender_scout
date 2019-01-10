class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.integer :number, null: true
      t.timestamps
    end

    add_index :roles, :name
  end
end
