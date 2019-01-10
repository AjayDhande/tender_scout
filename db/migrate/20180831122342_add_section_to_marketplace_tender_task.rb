class AddSectionToMarketplaceTenderTask < ActiveRecord::Migration[5.1]
  def change
    add_reference :marketplace_tender_tasks, :section#, #foreign_key: true
    add_foreign_key :marketplace_tender_tasks, :marketplace_tender_task_sections, column: :section_id
  end
end
