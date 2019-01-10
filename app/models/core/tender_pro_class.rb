class Core::TenderProClass < ApplicationRecord
  self.table_name = "core_tenders_pro_classes"
  belongs_to :tender
  belongs_to :pro_class
end
