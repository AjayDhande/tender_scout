class AddExportToSearchMonitor < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :export, :string
  end
end
