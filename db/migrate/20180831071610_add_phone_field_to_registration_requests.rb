class AddPhoneFieldToRegistrationRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :registration_requests, :phone, :string, null: true
  end
end
