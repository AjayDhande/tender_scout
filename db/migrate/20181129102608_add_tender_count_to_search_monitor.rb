class AddTenderCountToSearchMonitor < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :tenders_count, :integer
  end
end
