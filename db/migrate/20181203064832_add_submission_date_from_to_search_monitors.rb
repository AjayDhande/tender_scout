class AddSubmissionDateFromToSearchMonitors < ActiveRecord::Migration[5.1]
  def change
    add_column :search_monitors, :submission_date_from, :datetime
  end
end
