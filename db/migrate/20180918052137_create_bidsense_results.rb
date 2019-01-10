class CreateBidsenseResults < ActiveRecord::Migration[5.1]
  def change
    create_table :bidsense_results do |t|
      t.float :budget
      t.float :geography
      t.float :subject
      t.float :incumbent
      t.float :time
      t.float :buyer_related
      t.references :profile, foreign_key: true
      t.references :tender#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :bidsense_results, :core_tenders, column: :tender_id
  end
end
