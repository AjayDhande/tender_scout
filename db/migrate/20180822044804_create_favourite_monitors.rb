class CreateFavouriteMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :favourite_monitors do |t|
      t.references :user, foreign_key: true
      t.references :search_monitor, foreign_key: true

      t.timestamps
    end
  end
end
