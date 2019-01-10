class AddProfileTypeToProfile < ActiveRecord::Migration[5.1]
  def change
  	remove_column :profiles, :profile_type, :integer
    add_column :profiles, :profile_type, :string, array: true, default: ['consultant']
  end
end
