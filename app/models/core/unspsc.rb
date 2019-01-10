class Core::Unspsc < ApplicationRecord
  self.table_name = "core_unspsces"
  has_many :tender_unspsces, class_name: 'TenderUnspsc'
  has_many :tenders, through: :tender_unspsces

  def format_fields
    {
      unspsc_codes: [code]
    }
  end

  def code_name
    'unspsc'
  end
end
