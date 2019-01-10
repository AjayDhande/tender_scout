class Marketplace::UserTenderStatus < ApplicationRecord
 belongs_to :user
  enum status: [:unread, :read, :qualifying, :competing, :awaiting_result, :won_lost]
end
