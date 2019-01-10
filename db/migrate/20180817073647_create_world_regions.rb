class CreateWorldRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :world_regions do |t|
      t.string :code, null: false, default: ''
      t.string :name, null: false, default: ''
    end

  end
end
