class AddAttachmentLinkTablesToCriterias < ActiveRecord::Migration[5.1]
  def change
  	create_table :attachments_marketplace_tender_award_criteria, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true,index: { name: 'index_attachments_tender_a_criterium_on_attachment_id' }
      t.references :tender_award_criterium, index: {name: 'index_attachments_tender_a_criterium_on_award_criterium_id'}
    end

    add_foreign_key :attachments_marketplace_tender_award_criteria, :marketplace_tender_award_criteria, column: :tender_award_criterium_id

    create_table :attachments_marketplace_tender_qualification_criteria, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true, index: { name: 'index_attachments_tender_q_criteria_on_attachment_id' }
      t.references :tender_qualification_criteria, index: {name: 'index_attachments_tender_q_criteria_on_award_criteria_id'}
    end

    add_foreign_key :attachments_marketplace_tender_qualification_criteria, :marketplace_tender_qualification_criteria, column: :tender_qualification_criteria_id
  end
end
