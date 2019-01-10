class Core::TenderCategory < ApplicationRecord
  self.table_name = "core_tenders_categories"
  belongs_to :tender
  belongs_to :category
end
