class AddIsArchivedToSearchMonitors < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :is_archived, :boolean, default: false
  end
end
