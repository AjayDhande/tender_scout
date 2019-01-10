class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :fullname
      t.string :display_name
      t.string :company
      t.string :timezone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
