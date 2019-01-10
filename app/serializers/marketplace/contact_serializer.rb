class Marketplace::ContactSerializer < ActiveModel::Serializer
  attributes :contact_point
  attributes :email
end
