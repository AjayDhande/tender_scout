class CreateCompeteComments < ActiveRecord::Migration[5.1]
  def change
    create_table :compete_comments do |t|
      t.text :message, null: false
      t.integer :parent_id, null: true
      t.references :user, foreign_key: true
      t.references :tender
      t.timestamps
    end

    add_foreign_key :compete_comments, :core_tenders, column: :tender_id
  end
end
