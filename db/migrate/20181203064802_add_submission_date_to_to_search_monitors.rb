class AddSubmissionDateToToSearchMonitors < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :submission_date_to, :datetime
  end
end
