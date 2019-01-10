class NoteSerializer < ActiveModel::Serializer
  attributes :id, :profile_id, :body, :created_at, :updated_at, :tender_id
end