class CreateTenderTaskAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :tender_task_answers do |t|
      t.boolean :pass_fail, null: true
      t.integer :score, null: true
      t.boolean :closed, null: false, default: false
      t.references :user, foreign_key: true
      t.references :tender_task
      t.references :tender
      t.timestamps
    end

    add_foreign_key :tender_task_answers, :core_tenders, column: :tender_id
    add_foreign_key :tender_task_answers, :marketplace_tender_tasks, column: :tender_task_id
  end
end
