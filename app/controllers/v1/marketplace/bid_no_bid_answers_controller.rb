class V1::Marketplace::BidNoBidAnswersController < ApplicationController
  before_action :set_marketplace_bid_no_bid_answer, only: [:show, :update, :destroy]
  after_action :verify_authorized
  # GET /marketplace/bid_no_bid_answers
  def index
    @marketplace_bid_no_bid_answers = ::Marketplace::BidNoBidAnswer.all
    authorize @marketplace_bid_no_bid_answers
    render json: @marketplace_bid_no_bid_answers
  end

  # GET /marketplace/bid_no_bid_answers/1
  def show
    authorize @marketplace_bid_no_bid_answer
    render json: @marketplace_bid_no_bid_answer
  end

  # POST /marketplace/bid_no_bid_answers
  def create
    authorize ::Marketplace::BidNoBidAnswer
    @marketplace_bid_no_bid_answer = Marketplace::BidNoBidAnswer.new(marketplace_bid_no_bid_answer_params)

    if @marketplace_bid_no_bid_answer.save
      render json: @marketplace_bid_no_bid_answer, status: :created, location: @marketplace_bid_no_bid_answer
    else
      render json: @marketplace_bid_no_bid_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/bid_no_bid_answers/1
  def update
    authorize @marketplace_bid_no_bid_answer
    if @marketplace_bid_no_bid_answer.update(marketplace_bid_no_bid_answer_params)
      render json: @marketplace_bid_no_bid_answer
    else
      render json: @marketplace_bid_no_bid_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/bid_no_bid_answers/1
  def destroy
    @marketplace_bid_no_bid_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_bid_no_bid_answer
      @marketplace_bid_no_bid_answer = ::Marketplace::BidNoBidAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_bid_no_bid_answer_params
      params.permit(:answer_text, :position, :bid_no_bid_question_id)
    end
end
