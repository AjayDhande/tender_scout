class RemoveAttachmentForeignKeys < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :attachments_marketplace_tender_award_criteria, :marketplace_tender_award_criteria
    remove_foreign_key :attachments_marketplace_tender_qualification_criteria, :marketplace_tender_qualification_criteria
  end
end
