class AllowNullInOrganizationName < ActiveRecord::Migration[5.1]
  def change
    change_column :core_organizations, :name, :string, :null => true
  end
end
