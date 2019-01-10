class V1::Marketplace::CollaborationInterestsController < ApplicationController
  include ActionController::Serialization
  after_action :verify_authorized
  before_action :set_collaboration_interest, only: [:show, :destroy]
  before_action :set_tender

  def index
    authorize CollaborationInterest
    collaborations = GetCollaborations.call(params: index_params, user: current_user)
    result = collaborations.results
    # collaborations.results.map do |e| 
    #   is_collaborated = false
    #   collaboration = Marketplace::Collaboration.where(tender: @tender).try(:first)
    #   is_collaborated = true if collaboration && collaboration.tender_collaborators.where(user: current_user).count > 0
    #   result << {
    #     is_collaborated: is_collaborated,
    #     profile: ProfileSerializer.new(e)
    #   }
    # end
    render json: result
  end

  def show
    authorize CollaborationInterest
    render json: @collaboration_interest
  end

  def create
    authorize CollaborationInterest
    result = CreateInterestToCollaborate.call(params: interest_params, user: current_user)
    if result.success?
      render json: nil, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def update
    authorize CollaborationInterest
    # result = UpdateProfile.call(profile: @profile, params: params, user: current_user)
    # if result.success?
    #   render json: result.profile
    # else
    #   render json: result.errors, status: result.code
    # end
  end

  def destroy
    authorize CollaborationInterest
    # @profile.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collaboration_interest
    @collaboration_interest = CollaborationInterest.find(params[:id])
  end

  def set_tender
    @tender = Core::Tender.find(params[:tender_id])
  end

  # Only allow a trusted parameter "white list" through.
  def index_params
    params.permit(:match, :interest, :type, :tender_id)
  end

  def interest_params
    params.permit(:current_password, :message, :is_public, :tender_id)
  end
end
