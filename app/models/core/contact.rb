class Core::Contact < ApplicationRecord
  self.table_name = 'core_contacts'
  has_many :tender_contacts
  has_many :tenders, through: :tender_contacts

  def format_fields
    {
      contact_point: contact_point,
      contact_phone: phone,
      contact_email: email
    }
  end
end
