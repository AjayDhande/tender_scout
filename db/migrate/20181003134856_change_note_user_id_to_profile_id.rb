class ChangeNoteUserIdToProfileId < ActiveRecord::Migration[5.1]
  def change
    rename_column :notes, :user_id, :profile_id
  end
end
