class Marketplace::TenderCollaborator < ApplicationRecord
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration'
  belongs_to :user
  belongs_to :invited_by_user, class_name: 'User'
  enum role: [:owner, :admin, :editor, :viewer]

  
  enum status: [:active, :pending, :ignore]

  scope :active, -> { where(status: :active) }
  scope :pending, -> { where(status: :pending) }
  scope :ignored, -> { where(status: :ignore) }

  validates :role, presence: true
  validates :user, uniqueness: { scope: [:collaboration_id] }
end
