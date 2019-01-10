class AddDeadlineToTaskAndAwardCriteria < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_tasks, :deadline, :datetime
    add_column :marketplace_tender_award_criteria, :deadline, :datetime
  end
end
