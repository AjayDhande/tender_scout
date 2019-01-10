class CaseStudiesIndustryCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :case_studies_industry_codes, id: false, force: :cascade do |t|
      t.references :industry_code, foreign_key: true
      t.references :case_study, foreign_key: true
    end
  end
end
