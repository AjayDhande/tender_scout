class InviteSerializer < ActiveModel::Serializer
  attributes :collaboration_id, :tender, :invited_user, :role 
  
end
