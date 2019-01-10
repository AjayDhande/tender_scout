class Core::TenderContact < ApplicationRecord
  self.table_name = 'core_tenders_contacts'
  belongs_to :tender
  belongs_to :contact
end
