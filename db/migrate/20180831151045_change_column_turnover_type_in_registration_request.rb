class ChangeColumnTurnoverTypeInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :turnover, :string
  end
end
