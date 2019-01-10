class ChangeTenderCompleteTimeTypeInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :tender_complete_time, :string
  end
end
