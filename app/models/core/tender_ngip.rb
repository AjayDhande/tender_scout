class Core::TenderNgip < ApplicationRecord
  self.table_name = "core_tenders_ngip_codes"
  belongs_to :tender
  belongs_to :ngip, foreign_key: :ngip_code_id
end
