class AllowNullInTenderPublishedDate < ActiveRecord::Migration[5.1]
  def change
    change_column :core_tenders, :published_on, :datetime, :null => true
  end
end
