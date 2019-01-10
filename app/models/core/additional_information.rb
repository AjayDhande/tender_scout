class Core::AdditionalInformation < ApplicationRecord
  belongs_to :tender
  self.table_name = "core_additional_information"

  def format_fields
    {
      additional_information: [
        { title: title, url: url }
      ]
    }
  end
end
