class CompeteAnswer < ApplicationRecord
  belongs_to :compete_comment
  belongs_to :user
end
