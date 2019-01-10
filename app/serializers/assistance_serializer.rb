class AssistanceSerializer < ActiveModel::Serializer
  attributes :id, :assistance_type, :status, :message,
             :user_id, :tender_id, :created_at

  attribute(:fullname) { object.user.profiles.first.fullname }
  attribute(:email) { object.user.email }

  def profile
    object.try(:user).profiles.where(profile_type: :consultant).first
  end


end
