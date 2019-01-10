class ChangeOrganisationCountTypeInRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :registration_requests, :organisation_count, :string
  end
end
