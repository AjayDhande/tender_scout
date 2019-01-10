class AddBuyerToSearchMonitor < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :buyer, :string
  end
end
