class CaseStudy < ApplicationRecord
  belongs_to :profile

  has_and_belongs_to_many :industry_codes
  has_and_belongs_to_many :galleries
end
