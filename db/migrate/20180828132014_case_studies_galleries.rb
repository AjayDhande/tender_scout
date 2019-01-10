class CaseStudiesGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :case_studies_galleries, id: false, force: :cascade do |t|
      t.references :gallery, foreign_key: true
      t.references :case_study, foreign_key: true
    end
  end
end
