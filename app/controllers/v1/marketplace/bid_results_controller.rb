class V1::Marketplace::BidResultsController < ApplicationController
include UserTenderStatusChanger
  def create
    @result = ::Marketplace::BidResult.find_or_initialize_by(marketplace_collaboration_id: answer_params[:marketplace_collaboration_id],
                                                              tender_award_criteria_id: answer_params[:tender_award_criteria_id])
    @result.attributes = answer_params
    if @result.save
      user_won_lost_tender(answer_params[:marketplace_collaboration_id])
      render json: @result, status: :created
    else
      render json: @result.errors, status: 422
    end
  end
  private
  def answer_params
    params.permit( :marketplace_collaboration_id, :actual_score, :winning_score, :tender_award_criteria_id)
  end

end