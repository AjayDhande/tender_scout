class UserFavouriteTender < ApplicationRecord
  belongs_to :user
  belongs_to :tender, class_name: 'Core::Tender'

  validates_presence_of :user, :tender
end
