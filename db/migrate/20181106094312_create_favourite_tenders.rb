class CreateFavouriteTenders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_favourite_tenders do |t|
      t.references :user, foreign_key: true
      t.references :tender

      t.timestamps
    end
    add_foreign_key :user_favourite_tenders, :core_tenders, column: :tender_id
  end
end
