class TenderBidResultSerializer < ActiveModel::Serializer
  attribute(:award_criteria_section) do
  object
  end
  attribute(:award_criteries) do
    object.try(:award_criteries)
  end
  attribute(:bid_results) do
    bid_result = []
    object.try(:award_criteries).each do |criteria|
     bid_result << criteria.try(:marketplace_bid_results) if criteria.marketplace_bid_results.any?
    end
    bid_result.flatten
  end
end