class V1::Marketplace::TenderQualificationCriteriaAnswersController < ApplicationController
  # after_action :verify_authorized
  def index #TODO move TenderQualificationCriteria model Marketplace::TenderQualificationCriteria
    render json: ::Marketplace::TenderQualificationCriteriaAnswer.where(tender_qualification_criteria_id: params[:tender_qualification_criteria_id]).where(user: current_user)
  end

  def create
    result = CreateTenderQualificationCriteriaAnswer.call(params: answer_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def close
    result = CloseTenderQualificationCriteriaAnswer.call(params: close_params, user: current_user)
    if result.success?
      render json: result.answer, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def paginate_params
    params.permit(:page, :page_size)
  end

  def answer_params
    params.permit(:tender_qualification_criteria_id, :tender_id, :pass_fail, :score, :closed, :collaboration_id)
  end

  def close_params
    params.permit(:id, :tender_qualification_criteria_id, :tender_id, :closed)
  end
end
