class AddMonitorTypeToSearchMonitors < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :monitor_type, :integer
    SearchMonitor.reset_column_information
    SearchMonitor.update_all monitor_type: SearchMonitor.monitor_types[:personal]
  end
end
