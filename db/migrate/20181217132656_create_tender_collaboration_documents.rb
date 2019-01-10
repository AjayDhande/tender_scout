class CreateTenderCollaborationDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :tender_collaboration_documents do |t|
          t.string :file
          t.string :content_type, null: true
          t.string :file_size, null: true
          t.integer :tender_id
          t.integer :collaboration_id
          t.integer :user_id
    end
  end
end
