class Assistance < ApplicationRecord
  include Pageable
  attr_accessor :current_password
  belongs_to :user
  belongs_to :tender, class_name: 'Core::Tender'

  enum assistance_type: [:tender, :bid, :other]
  enum status: [:opened, :closed]

  validates_presence_of :assistance_type#, :status
  validate :is_correct_password

  private
  def is_correct_password
  	unless self.user.valid_password?(self.current_password)
  	  errors.add(:password, 'Password is invalid!')
  	end
  end
  

end
