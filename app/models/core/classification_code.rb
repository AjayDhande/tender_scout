class Core::ClassificationCode < ApplicationRecord
  include ActiveModel::Serialization
  self.table_name = "core_classification_codes"

  def code_name
    'classification'
  end

  def format_fields
    {
      classification_code: code,
      classification_description: description
    }
  end
end
