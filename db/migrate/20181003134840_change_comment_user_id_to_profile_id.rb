class ChangeCommentUserIdToProfileId < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :user_id, :profile_id
  end
end
