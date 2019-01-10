class AddDescriptionToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :description, :text
  end
end
