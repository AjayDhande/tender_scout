class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :status, :profile

  def profile
    object.try(:user).profiles.where(profile_type: :consultant).first
  end
end
