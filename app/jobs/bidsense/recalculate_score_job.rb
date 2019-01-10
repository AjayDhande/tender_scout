class Bidsense::RecalculateScoreJob < ApplicationJob
  queue_as :default

  def perform(profile: nil, tender: nil)

    # return unless profile or tender
    # if profile && tender
    #   update_results(profile, tender)
    # elsif profile
    #   Core::Tender.all.each do |tender|
    #     update_results(profile, tender)
    #   end
    # elsif tender
    #   Profile.all.each do |profile|
    #     update_results(profile, tender)
    #   end
    # end  
  end

  private

  def update_results(profile, tender)
    bidsense = Bidsense.score(profile: profile, tender: tender)
    average_bidsense = avg_bidsense(bidsense)
    if average_bidsense >= 0.5
      result = BidsenseResult.find_or_create_by(profile: profile, tender: tender)
      result.update_attributes(bidsense)
      result.average_score = average_bidsense
      result.save
    end
  end

  def avg_bidsense(result)
    vals = result.map { |_, v| v if v >= 0 }.delete_if { |v| v == nil }
    return vals.sum / vals.count
  end
end

