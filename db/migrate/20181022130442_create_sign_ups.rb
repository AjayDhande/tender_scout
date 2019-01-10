class CreateSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_up_requests do |t|
        t.string :fullname, null: false, default: ''
        t.string :phone, null: false, default: ''
        t.string :email, null: false, default: ''
        t.string :company, null: false, default: ''
        t.string :state, null: false, default: ''
        t.string :country, null: false, default: ''
        t.string :city, null: false, default: ''
        t.string :sector, null: true
        t.json :markets, null: false, default: {}
        t.integer :tender_level, null: false, default: 0
        t.integer :number_public_contracts, null: false, default: 0
        t.float :tender_complete_time, null: false, default: 0.00
        t.integer :organisation_count, null: false, default: 0
        t.timestamps

        t.references :country
        t.references :industry, foreign_key: true
      end
      add_foreign_key :sign_up_requests, :core_countries, column: :country_id
  end
end
