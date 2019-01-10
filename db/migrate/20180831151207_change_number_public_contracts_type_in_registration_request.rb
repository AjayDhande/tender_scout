class ChangeNumberPublicContractsTypeInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :number_public_contracts, :string
  end
end
