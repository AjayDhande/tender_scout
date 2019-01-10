class Core::Organization < ApplicationRecord
  self.table_name = "core_organizations"
  belongs_to :country
  has_many :tenders

  def format_fields
    {
      organization_name: name,
      organization_phone: phone
    }
  end

  def complete_tenders
    self.tenders.where(status: :archived)
  end

end
