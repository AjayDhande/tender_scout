class AddFilesToMarketplaceTenderQualificationCriteria < ActiveRecord::Migration[5.1]
  def change
    add_column :marketplace_tender_qualification_criteria, :files, :json
  end
end
