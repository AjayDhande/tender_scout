class Marketplace::CollaborationSerializer < ActiveModel::Serializer
  attributes :id
  has_many :users, through: :tender_collaborators do
    
    link :collaboration_role, 'asd'
  end
  has_many :tender_collaborators
  # has_one :tender
end
