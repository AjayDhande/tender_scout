class AddFieldsToTender < ActiveRecord::Migration[5.1]
  def change
    add_column :core_tenders, :dispatch_date, :datetime
  end
end
