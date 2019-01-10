class RenameCoverImgUrlToCoverImgInProfiles < ActiveRecord::Migration[5.1]
  def change
    rename_column :profiles, :cover_img_url, :cover_img
  end
end
