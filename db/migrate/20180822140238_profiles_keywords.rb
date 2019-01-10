class ProfilesKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords_profiles, id: false, force: :cascade do |t|
      t.references :keyword, foreign_key: true
      t.references :profile, foreign_key: true
    end
  end
end
