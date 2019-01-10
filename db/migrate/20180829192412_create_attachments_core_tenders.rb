class CreateAttachmentsCoreTenders < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments_core_tenders, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true
      t.references :tender
    end

    add_foreign_key :attachments_core_tenders, :core_tenders, column: :tender_id
  end
end
