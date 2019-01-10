class Core::Ngip < ApplicationRecord
  self.table_name = "core_ngip_codes"
  has_many :tender_ngips
  has_many :tenders, through: :tender_ngips

  def format_fields
    {
      ngip_codes: [code]
    }
  end

  def code_name
    'ngip'
  end
end
