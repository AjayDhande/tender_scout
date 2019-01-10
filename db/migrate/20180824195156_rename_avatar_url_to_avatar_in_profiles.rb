class RenameAvatarUrlToAvatarInProfiles < ActiveRecord::Migration[5.1]
  def change
    rename_column :profiles, :avatar_url, :avatar
  end
end
