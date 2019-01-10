class Supplier < ApplicationRecord
  belongs_to :user
  belongs_to :tender, :class_name => 'Core::Tender'

  enum status: [:pending, :approved]
end
