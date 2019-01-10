class AfricanCode < ApplicationRecord
  self.table_name = "core_african_codes"
  include ActiveModel::Serialization

  def code_name
    'african'
  end
end
