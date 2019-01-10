class AddStatusToCoreTenders < ActiveRecord::Migration[5.1]
  def change
    add_column :core_tenders, :status, :integer, default: 0
  end
end
