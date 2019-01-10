class Core::Document < ApplicationRecord
  belongs_to :tender
  self.table_name = "core_documents"

  def format_fields
    {
      documents: [
        { title: title, url: url }
      ]
    }
  end
end
