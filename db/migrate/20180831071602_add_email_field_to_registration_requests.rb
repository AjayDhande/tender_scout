class AddEmailFieldToRegistrationRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :registration_requests, :email, :string, null: false, default: ''
  end
end
