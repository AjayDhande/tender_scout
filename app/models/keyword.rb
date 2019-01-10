class Keyword < ApplicationRecord
  has_and_belongs_to_many :profiles, dependent: :destroy
end
