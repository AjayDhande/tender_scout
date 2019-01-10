class Core::TenderUnspsc < ApplicationRecord
  self.table_name = "core_tenders_unspsces"
  belongs_to :tender
  belongs_to :unspsc
end
