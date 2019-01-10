class Core::Country < ApplicationRecord
  self.table_name = "core_countries"
  belongs_to :currency
  #belongs_to :world_region, optional: true

  def format_fields
    {
      country_name: name,
      world_subregion: world_subregion,
      world_region: world_region
    }
  end
end
