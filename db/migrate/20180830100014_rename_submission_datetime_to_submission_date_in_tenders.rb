class RenameSubmissionDatetimeToSubmissionDateInTenders < ActiveRecord::Migration[5.1]
  def change
    rename_column :core_tenders, :submission_datetime, :submission_date
  end
end
