class CreateCoreTendersUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :core_tenders_users, id: false, force: :cascade do |t|
      t.references :user, foreign_key: true
      t.references :tender
    end

    add_foreign_key :core_tenders_users, :core_tenders, column: :tender_id
  end
end
