class Core::NhsEClass < ApplicationRecord
  self.table_name = "core_nhs_e_classes"
  has_many :tender_nhs_e_classes, foreign_key: :nhs_eclass_id
  has_many :tenders, through: :tender_nhs_e_classes

  def format_fields
    {
      nhs_e_class_codes: [code]
    }
  end

  def code_name
    'nhs_e_class'
  end
end
