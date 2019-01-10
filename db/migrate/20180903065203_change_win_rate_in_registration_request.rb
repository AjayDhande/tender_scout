class ChangeWinRateInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :win_rate, :string
  end
end
