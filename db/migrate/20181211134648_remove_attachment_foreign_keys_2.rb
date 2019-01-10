class RemoveAttachmentForeignKeys2 < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :attachments_marketplace_tender_award_criteria, :attachments
    remove_foreign_key :attachments_marketplace_tender_qualification_criteria, :attachments
  end
end
