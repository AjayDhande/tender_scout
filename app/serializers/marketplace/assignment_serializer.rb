class Marketplace::AssignmentSerializer < ActiveModel::Serializer
 attributes :id, :assignable_id, :user_id
end