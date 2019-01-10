class Core::TenderCpv < ApplicationRecord
  self.table_name = "core_tenders_cpvs"
  belongs_to :tender
  belongs_to :cpv
end
