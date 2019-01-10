class Core::Gsin < ApplicationRecord
  self.table_name = "core_gsin_codes"
  has_many :tender_gsins, foreign_key: :gsin_id
  has_many :tenders, through: :tender_gsins

  def format_fields
    {
      gsin_codes: [code]
    }
  end

  def code_name
    'gsin'
  end
end
