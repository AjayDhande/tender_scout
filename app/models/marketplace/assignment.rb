class Marketplace::Assignment < ApplicationRecord
  belongs_to :assignable, polymorphic: true
  belongs_to :user
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration'
  before_validation :check_available, on: :create
  
  private

  def check_available
    if Marketplace::Assignment.where(assignable_type: assignable_type, assignable_id: assignable_id, collaboration_id: collaboration_id).present?
      errors.add(:error, 'Assignment is already exist')
    end
  end
end
