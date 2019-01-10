class Core::Award < ApplicationRecord
  self.table_name = "core_awards"
  belongs_to :organization
  belongs_to :tender

  def format_fields
    {
      winner_ids: [
        organization_id
      ]
    }
  end
end
