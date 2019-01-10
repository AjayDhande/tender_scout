class UpdateAttachmentForeignKeys < ActiveRecord::Migration[5.1]
  def change
    # remove the old foreign_key
    remove_foreign_key :attachments_marketplace_tender_award_criteria, :marketplace_tender_award_criteria
    remove_foreign_key :attachments_marketplace_tender_qualification_criteria, :marketplace_tender_qualification_criteria
    # add the new foreign_key
    add_foreign_key :attachments_marketplace_tender_award_criteria, :marketplace_tender_award_criteria, column: :tender_award_criterium_id, on_delete: :cascade
    add_foreign_key :attachments_marketplace_tender_qualification_criteria, :marketplace_tender_qualification_criteria, column: :tender_qualification_criteria_id, on_delete: :cascade

  end
end