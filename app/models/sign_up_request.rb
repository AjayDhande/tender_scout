class SignUpRequest < ApplicationRecord
  belongs_to :country, class_name: 'Core::Country'
  belongs_to :industry
end