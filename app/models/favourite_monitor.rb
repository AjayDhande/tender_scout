class FavouriteMonitor < ApplicationRecord
  belongs_to :user
  belongs_to :search_monitor

  validates_presence_of :user, :search_monitor
end
