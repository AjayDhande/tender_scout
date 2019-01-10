class AddSectionToMarketplaceTenderCriteria < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_criteria, :section#, #foreign_key: true
    add_foreign_key :marketplace_tender_criteria, :marketplace_tender_criteria_sections, column: :section_id
  end
end
