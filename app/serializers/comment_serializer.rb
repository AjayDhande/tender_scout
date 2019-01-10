class CommentSerializer < ActiveModel::Serializer
  attributes :id, :profile_id, :body, :created_at, :updated_at, :parent_id, :tender_id
end