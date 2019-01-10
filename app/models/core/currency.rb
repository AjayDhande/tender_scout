class Core::Currency < ApplicationRecord
  self.table_name = "core_currencies"

  def format_fields
    {
      currency_name: name,
      currency_code: code
    }
  end
end
