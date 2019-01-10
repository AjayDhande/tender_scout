class RemoveSectorFromRegistrationRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :registration_requests, :sector
  end
end
