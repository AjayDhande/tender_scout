class CompeteAnswerSerializer < ActiveModel::Serializer
  attributes :id, :message, :profile, :created_at, :updated_at
  attribute(:comment_id) { object.compete_comment_id }

  def profile
    object.try(:user).profiles.where(profile_type: :consultant).first
  end
end
