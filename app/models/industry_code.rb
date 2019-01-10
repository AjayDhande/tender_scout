class IndustryCode < ApplicationRecord
  include Pageable
  belongs_to :industry

  def self.search_codes(code)
    TenderCodesIndex.query(match:{ code: code} )
  end
end
