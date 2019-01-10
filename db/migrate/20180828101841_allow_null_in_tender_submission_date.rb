class AllowNullInTenderSubmissionDate < ActiveRecord::Migration[5.1]
  def change
    change_column :core_tenders, :submission_datetime, :datetime, :null => true
  end
end
