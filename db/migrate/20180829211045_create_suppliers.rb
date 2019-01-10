class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :status, null: false, default: :pending
      t.references :user, foreign_key: true
      t.references :tender
      t.timestamps
    end

    add_foreign_key :suppliers, :core_tenders, column: :tender_id
  end
end
