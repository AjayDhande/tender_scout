class BidsenseResult < ApplicationRecord
  belongs_to :profile
  belongs_to :tender, class_name: 'Core::Tender'
end
