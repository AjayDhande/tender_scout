class CreateRegistrationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_requests do |t|
      t.string :fullname, null: false, default: ''
      t.string :company, null: false, default: ''
      t.integer :company_size, null: false, default: 0
      t.string :state, null: false, default: ''
      t.string :country, null: false, default: ''
      t.string :city, null: false, default: ''
      t.string :sector, null: true
      t.integer :turnover, null: false, default: 0
      t.json :markets, null: false, default: {}
      t.integer :tender_level, null: false, default: 0
      t.float :win_rate, null: false, default: 0.00
      t.integer :number_public_contracts, null: false, default: 0
      t.boolean :do_use_automation, null: false, default: false
      t.boolean :do_use_collaboration, null: false, default: false
      t.boolean :do_use_bid_no_bid, null: false, default: false
      t.boolean :do_use_bid_library, null: false, default: false
      t.boolean :do_use_feedback, null: false, default: false
      t.boolean :do_collaborate, null: false, default: false
      t.float :tender_complete_time, null: false, default: 0.00
      t.integer :organisation_count, null: false, default: 0
      t.boolean :do_processed, null: false, default: false
      t.timestamps

      t.references :country#, foreign_key: true
      t.references :industry, foreign_key: true
    end
    add_foreign_key :registration_requests, :core_countries, column: :country_id
  end
end
