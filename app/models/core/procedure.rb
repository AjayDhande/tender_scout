class Core::Procedure < ApplicationRecord
  self.table_name = "core_procedures"

  has_many :tenders

  def format_fields
    {
      procedure_name: name
    }
  end
end
