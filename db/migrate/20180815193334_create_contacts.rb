class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.integer :type
      t.string :value
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
