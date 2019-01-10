class TenderSerializer < ActiveModel::Serializer
  attributes  :id, :title, :description, :published_on, :awarded_on, :submission_date, :deadline_date,
              :cancelled_on, :procedure_id, :procedure_name, :currency_id, :currency_name, :organization_id, :organization_name,
              :status_cd, :contract_authority_type, :main_activity, :contract_category, :location, :flagged_as_sme_friendly, 
              :flagged_as_vcs_friendly, :nuts_codes, :supplementary_codes, :contract_duration_in_days, 
              :contract_duration_in_months, :contract_duration_in_years, :contract_start_date, 
              :contract_end_date, :award_value, :lowest_offer_value, :highest_offer_value, 
              :offers_count, :estimated_value, :estimated_low_value, :estimated_high_value, 
              :framework_duration_in_days, :framework_duration_in_months, :framework_duration_in_years, 
              :framework_estimated_value, :framework_estimated_low_value, :framework_estimated_high_value, 
              :keywords, :created_at, :updated_at, :award_published_on, :potential_retender_date, :tender_urls, 
              :award_urls, :spider_id, :delta, :file_reference_number, :naics_code_id, 
              :classification_code_id, :salesforce_id, :expected_revenue, :forecast_category, :last_modified_by, 
              :lead_source, :next_step, :private, :probability, :quantity, :stage, :salesforce_type, :industry, 
              :partner, :primary, :role, :competitor, :strengths, :weaknesses, :set_aside, :archiving_policy, 
              :archive_date, :original_set_aside, :awarded_at, :place_of_performance, :request_awards, 
              :retender_status, :status, :dispatch_date, :questioning_deadline, :answering_deadline, :status

  attribute(:creator) { UserSerializer.new(object.creator) if object.creator }
  attribute(:country) { CountrySerializer.new(object.organization.try(:country)) if object.organization }
  attribute(:city) { object.try(:organization).try(:city_name) }
  attribute(:contact_email) { object.try(:organization).try(:email) }
  attribute(:contact_phone) { object.try(:organization).try(:phone) }
  has_many :contacts, serializer: Marketplace::ContactSerializer
  attribute(:classification) { object.try(:classification).try(:description) }
  attribute(:is_scrapped) { object.creator.blank? }
  # attribute(:creator) { object.try(:creator)}
  has_many :naicses, serializer: Core::NaicsSerializer

  attribute(:bid_status_last_answer_date) do
    dates = object.award_criteria_answers.where(user: current_user).pluck :created_at
    dates += object.qualification_criteria_answers.where(user: current_user).pluck :created_at
    dates.sort!
    dates.last
  end

  attribute(:bnb_last_answer_date) do
    dates = object.bid_no_bid_compete_answers.where(user: current_user).pluck :updated_at
    dates.sort!
    dates.last
  end

  attribute(:collaboration) do
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: object).ids, user: current_user).try(:first).try(:collaboration)
    collaborators = []
    collaboration.tender_collaborators.each do |tc|
      is_owner = (tc.try(:role) == 'owner') ? true : false

      collaborators << 
      {
        id: tc.user.id,
        email: tc.user.email,
        collaboration_role: tc.role,
        is_owner: is_owner,
        profiles: ActiveModel::Serializer::CollectionSerializer.new(tc.user.profiles,
                                                                 each_serializer: ProfileSerializer)
      }
    end if collaboration
    {
      id: collaboration.id,
      count: collaboration.tender_collaborators.count,
      users: collaborators
    } if collaboration
    # Marketplace::CollaborationSerializer.new(collaboration) if collaboration
  end

  attribute(:collaboration_count) do
    object.collaborations.count
  end
  
  attribute(:bidsense) do
    Bidsense.score(profile: current_user.profiles.first, tender: object, search_monitor: @instance_options[:search_monitor])
  end
  attribute(:bid_no_bid) do
    if current_user.free? || current_user.basic?
      nil
      else

    result = []
    Marketplace::BidNoBidQuestion.all.each do |question|
      result << question.as_json
      answer = object.bid_no_bid_compete_answers.where(user: current_user, bid_no_bid_question: question).try(:last).try(:bid_no_bid_answer)
      result.last[:answer] = answer
    end

    result
    end
    end

  attribute(:complete_status) do
    CollaboratorTenderStatus.score(user: current_user, tender: object)
  end

  attribute(:favourite) do
    if UserFavouriteTender.where(tender_id: object.id, user_id: current_user.id).present?
      true
    else
      false
    end
  end

  attribute(:user_status) do
    Marketplace::UserTenderStatus.find_by(user_id: current_user.id, tender_id: object.id).try(:status)
  end

  def current_user
    @instance_options[:current_user] || @instance_options[:scope]
  end
end
