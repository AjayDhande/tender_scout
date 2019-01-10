class Core::TenderGsin < ApplicationRecord
  self.table_name = "core_tenders_gsin_codes"
  belongs_to :tender
  belongs_to :gsin, foreign_key: :gsin_id
end
