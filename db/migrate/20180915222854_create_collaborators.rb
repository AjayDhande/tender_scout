class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.string :role
      t.references :user, foreign_key: true
      t.integer :collaboration_id
      t.timestamps
    end
  end
end
