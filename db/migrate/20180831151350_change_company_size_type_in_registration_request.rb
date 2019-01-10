class ChangeCompanySizeTypeInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :company_size, :string
  end
end
