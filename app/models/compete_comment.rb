class CompeteComment < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  belongs_to :user

  has_many :answers, class_name: 'CompeteAnswer'
end
