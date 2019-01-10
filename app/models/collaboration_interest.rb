class CollaborationInterest < ApplicationRecord
  include ActiveModel::Serialization

  belongs_to :tender, class_name: 'Core::Tender'
  belongs_to :user
end
