class ChangeProfileAndSignUp < ActiveRecord::Migration[5.1]
  def change
    change_column :profiles, :number_public_contracts, :string
    change_column :profiles, :tender_level, :string
    change_column :sign_up_requests, :number_public_contracts, :string
    change_column :sign_up_requests, :tender_level, :string
  end
end
