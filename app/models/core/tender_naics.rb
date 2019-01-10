class Core::TenderNaics < ApplicationRecord
  self.table_name = "core_tenders_naicses"
  belongs_to :tender
  belongs_to :naics
end
