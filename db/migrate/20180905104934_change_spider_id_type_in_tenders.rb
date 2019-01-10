class ChangeSpiderIdTypeInTenders < ActiveRecord::Migration[5.1]
  def change
    change_column :core_tenders, :spider_id, :string
  end
end
