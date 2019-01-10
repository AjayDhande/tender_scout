class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :content_type, null: true
      t.string :file_size, null: true
    end
  end
end
