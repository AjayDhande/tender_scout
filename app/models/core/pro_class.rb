class Core::ProClass < ApplicationRecord
  self.table_name = "core_pro_classes"
  has_many :tender_pro_class
  has_many :tenders, through: :tender_pro_class

  def format_fields
    {
      pro_class_codes: [code]
    }
  end

  def code_name
    'pro_class'
  end
end
