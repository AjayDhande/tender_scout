class RenameTaskToQualificationCriteria < ActiveRecord::Migration[5.1]
  def change
    drop_table :marketplace_tender_tasks, force: :cascade
    drop_table :marketplace_tender_task_sections, force: :cascade
    drop_table :marketplace_tender_task_answers, force: :cascade

    create_table :marketplace_tender_qualification_criterias do |t|
      t.integer "order"
      t.string "title"
      t.float "weight"
      t.bigint "tender_id"
      t.bigint "section_id"
      t.text "description"
      t.datetime "deadline"
      t.index ["section_id"], name: "index_marketplace_tender_q_c_on_section_id"
      t.index ["tender_id"], name: "index_marketplace_tender_q_c_on_tender_id"
      t.timestamps
    end
    create_table :marketplace_tender_qualification_criteria_sections do |t|
      t.integer "order"
      t.string "title"
      t.bigint "tender_id"
      t.index ["tender_id"], name: "index_marketplace_tender_q_c_sections_on_tender_id"
      t.timestamps
    end
    add_foreign_key :marketplace_tender_qualification_criteria_sections, :core_tenders, column: :tender_id
    add_foreign_key :marketplace_tender_qualification_criterias, :marketplace_tender_qualification_criteria_sections, column: :section_id

    create_table :tender_qualification_criteria_answers do |t|
      t.boolean "pass_fail"
      t.integer "score"
      t.boolean "closed", default: false, null: false
      t.bigint "user_id"
      t.bigint "tender_qualification_criteria_id"
      t.bigint "tender_id"
      t.index ["tender_id"], name: "index_marketplace_tender_q_c_answers_on_tender_id"
      t.index ["tender_qualification_criteria_id"], name: "index_marketplace_tender_q_c_answers_on_tender_q_c_id"
      t.index ["user_id"], name: "index_marketplace_tender_q_c_answers_on_user_id"
      t.timestamps
    end

    add_foreign_key :tender_qualification_criteria_answers, :core_tenders, column: :tender_id
    add_foreign_key :tender_qualification_criteria_answers, :marketplace_tender_qualification_criterias, column: :tender_qualification_criteria_id
  end
end

  