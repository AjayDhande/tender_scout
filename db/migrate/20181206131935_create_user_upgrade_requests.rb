class CreateUserUpgradeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :user_upgrade_requests do |t|
      t.references :user, foreign_key: true
      t.datetime :upgraded_at

      t.timestamps
    end
  end
end
