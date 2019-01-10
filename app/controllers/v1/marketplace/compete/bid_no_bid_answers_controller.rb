class V1::Marketplace::Compete::BidNoBidAnswersController < ApplicationController
  before_action :set_marketplace_compete_bid_no_bid_answer, only: [:show, :update, :destroy]
  before_action :set_tender
  after_action :verify_authorized
  # GET /marketplace/compete/bid_no_bid_answers
  def index
    @marketplace_compete_bid_no_bid_answers = @tender.bid_no_bid_answers

    render json: @marketplace_compete_bid_no_bid_answers
  end

  # GET /marketplace/compete/bid_no_bid_answers/1
  def show
    render json: @marketplace_compete_bid_no_bid_answer
  end

  # POST /marketplace/compete/bid_no_bid_answers
  def create
    @marketplace_compete_bid_no_bid_answer = @tender.bid_no_bid_answers.new(marketplace_compete_bid_no_bid_answer_params)

    if @marketplace_compete_bid_no_bid_answer.save
      render json: @marketplace_compete_bid_no_bid_answer, status: :created, location: @marketplace_compete_bid_no_bid_answer
    else
      render json: @marketplace_compete_bid_no_bid_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/compete/bid_no_bid_answers/1
  def update
    if @marketplace_compete_bid_no_bid_answer.update(marketplace_compete_bid_no_bid_answer_params)
      render json: @marketplace_compete_bid_no_bid_answer
    else
      render json: @marketplace_compete_bid_no_bid_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/compete/bid_no_bid_answers/1
  def destroy
    @marketplace_compete_bid_no_bid_answer.destroy
  end

  private
    def set_tender
      @tender = Core::Tender.find params[:tender_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_compete_bid_no_bid_answer
      @marketplace_compete_bid_no_bid_answer = Marketplace::Compete::BidNoBidAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_compete_bid_no_bid_answer_params
      params.permit(:answer_text, :bid_no_bid_answer_id, :comment, :bid_no_bid_question_id, :tender_id)
    end
end
