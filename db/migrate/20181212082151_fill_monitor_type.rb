class FillMonitorType < ActiveRecord::Migration[5.1]
  def change
  	SearchMonitor.where(monitor_type: nil).each { |e| e.personal! }
  end
end
