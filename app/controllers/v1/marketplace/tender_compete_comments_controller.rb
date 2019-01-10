class V1::Marketplace::TenderCompeteCommentsController < ApplicationController

  def index
    render json: CompeteComment.where(tender_id: params[:tender_id]).where(parent_id: nil)
  end

  def create
    result = CreateCompeteComment.call(params: comment_params, user: current_user)
    if result.success?
      render json: result.comment, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def answer
    result = CreateCompeteAnswer.call(params: answer_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def paginate_params
    params.permit(:page, :page_size)
  end

  def comment_params
    params.permit(:message, :parent_id, :tender_id)
  end

  def answer_params
    params.permit(:message, :parent_id, :tender_id, :id)
  end
end
