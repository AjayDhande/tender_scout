class AddDefaultValueToStatusInMonitors < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :search_monitors, :status, from: nil, to: []
  end
end
