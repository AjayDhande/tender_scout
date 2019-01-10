class Users::UpgradeRequestSerializer < ActiveModel::Serializer
  has_one :user, serializer: UserSerializer
  attributes  :id, :created_at, :upgraded_at
end
