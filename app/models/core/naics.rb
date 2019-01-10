class Core::Naics < ApplicationRecord
  self.table_name = "core_naicses"
  has_many :tender_naicses, class_name: 'TenderNaics'
  has_many :tenders, through: :tender_naicses

  def format_fields
    {
      naics_codes: [code]
    }
  end

  def code_name
    'naics'
  end
end
