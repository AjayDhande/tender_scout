class ProfilesIndustries < ActiveRecord::Migration[5.1]
  def change
    create_table :industries_profiles, id: false, force: :cascade do |t|
      t.references :industry, foreign_key: true
      t.references :profile, foreign_key: true
    end
  end
end
