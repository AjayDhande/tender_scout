class CreateCaseStudies < ActiveRecord::Migration[5.1]
  def change
    create_table :case_studies do |t|
      t.string :title, null: false
      t.text :description
      t.string :cover_img
      t.float :budget, null: false, default: 0
      t.string :video_list, array: true, default: []
      t.datetime :start_date
      t.datetime :delivery_date
      t.boolean :archived, null: false, default: false

      t.references :profile, foreign_key: true
    end
  end
end
