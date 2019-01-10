class AddIndustryToCoreTenders < ActiveRecord::Migration[5.1]
  def change
    add_reference :core_tenders, :industry, foreign_key: true
  end
end
