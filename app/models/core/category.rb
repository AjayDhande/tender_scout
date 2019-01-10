class Core::Category < ApplicationRecord
  self.table_name = "core_categories"
  has_many :tender_categories
  has_many :tenders, through: :tender_categories

  def format_fields
    {
      category_codes: [code]
    }
  end
end
