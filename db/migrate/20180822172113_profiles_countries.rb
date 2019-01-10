class ProfilesCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :core_countries_profiles, id: false, force: :cascade do |t|
      t.references :country
      t.references :profile, foreign_key: true
    end

    add_foreign_key :core_countries_profiles, :core_countries, column: :country_id
  end
end
