class AddStatusToSearchMonitor < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :status, :string, array: true
  end
end
