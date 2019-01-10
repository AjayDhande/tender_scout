class Core::TenderSfgov < ApplicationRecord
  self.table_name = "core_tenders_sfgov_codes"
  belongs_to :tender
  belongs_to :sfgov, foreign_key: :sfgov_code_id
end
