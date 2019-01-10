class CreateCriteriaAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :tender_criteria_answers do |t|
      t.boolean :pass_fail, null: true
      t.integer :score, null: true
      t.boolean :closed, null: false, default: false
      t.references :user, foreign_key: true
      t.references :tender_criteria
      t.references :tender
      t.timestamps
    end

    add_foreign_key :tender_criteria_answers, :core_tenders, column: :tender_id
    add_foreign_key :tender_criteria_answers, :marketplace_tender_criteria, column: :tender_criteria_id
  end
end
