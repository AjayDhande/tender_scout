class AddCompanyFieldToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :company, :string
  end
end
