class Core::TenderNhsEClass < ApplicationRecord
  self.table_name = "core_tenders_nhs_e_classes"
  belongs_to :tender
  belongs_to :nhs_e_class, foreign_key: :nhs_eclass_id
end
