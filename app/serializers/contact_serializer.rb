class ContactSerializer < ActiveModel::Serializer
  attributes :contact_type
  attributes :value
end
