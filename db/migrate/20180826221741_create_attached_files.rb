class CreateAttachedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :attached_files do |t|
      t.string :filename
      t.string :file_type
    end
  end
end
