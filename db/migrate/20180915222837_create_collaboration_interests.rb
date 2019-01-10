class CreateCollaborationInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :collaboration_interests do |t|
      t.text :message
      t.boolean :is_public
      t.references :user, foreign_key: true
      t.references :tender
      t.timestamps
    end

    add_foreign_key :collaboration_interests, :core_tenders, column: :tender_id
  end
end
