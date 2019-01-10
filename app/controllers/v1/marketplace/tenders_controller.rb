class V1::Marketplace::TendersController < ApplicationController
  include UserTenderStatusChanger
  include ActionController::Serialization
  before_action :set_tender, only: [:show, :update, :destroy, :set_avatar, :destroy_avatar, :publish, :get_bnb_data,
                                    :process_bnb_data, :best_bidsense_profiles , :complete_organization_tenders_list,
                                    :similar_opportunities_tenders, :add_favourite, :delete_favourite, :bid_result,
                                    :user_awaiting_result_tender]
  after_action :verify_authorized, except: [:set_avatar, :destroy_avatar, :publish,
                                    :process_bnb_data, :best_bidsense_profiles , :complete_organization_tenders_list,
                                            :current_buyer_company_won_list, :similar_opportunities_tenders,
                                            :add_favourite, :delete_favourite, :my_favourites, :bid_result,
                                            :user_awaiting_result_tender]
  # GET /profiles
  def index
    authorize Core::Tender
    tenders = Core::Tender.all
    # byebug
    @tenders = tenders.my_paginate(paginate_params)
    render json: { count: tenders.count, data: @tenders }, current_user: current_user
  end

  def get_bnb_data
    authorize @tender
    render json: @tender.get_bnb_data
  end

  def process_bnb_data
    answer = ::Marketplace::BidNoBidAnswer.find_by_id params[:answer_id]
    question = ::Marketplace::BidNoBidQuestion.find_by_id params[:question_id]
    if answer.bid_no_bid_question == question
      @tender.bid_no_bid_compete_answers.create!({
        bid_no_bid_answer: answer,
        bid_no_bid_question: question,
        user: current_user

        })
      user_qualifying_tender(current_user, @tender)
      render json: @tender.get_bnb_data
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  # GET /profiles/1
  def show
    authorize @tender
    user_read_tender(current_user, @tender)
    render json: @tender
  end

  # POST /profiles
  def create
    authorize Core::Tender
    result = CreateTender.call(params: params, user: current_user)
    if result.success?
      render json: result.tender, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    authorize @tender
    result = UpdateTender.call(tender: @tender, params: params, user: current_user)
    if result.success?
      render json: result.tender, current_user: current_user
    else
      render json: result.errors, status: result.code
    end
  end

  # DELETE /profiles/1
  def destroy
    result = DestroyTender.call(tender: @tender, params: tender_params, user: current_user)
    if result.success?
      render json: nil, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  def publish
    result = PublishTender.call(tender: @tender, user: current_user)
    if result.success?
      render json: nil, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  def compete
    result = CompeteProcessingInfo.call(params: compete_params, user: current_user)
    render json: {
      complete: result.complete
    }
  end

  def best_bidsense_profiles
     bidsenses = @tender.matched_competitor_bidsense
     profiles = bidsenses.map(&:profile)
     render json: { profiles: profiles, bidsense: bidsenses }
  end

  def current_buyer_company_won_list
    render json: []
  end

  def complete_organization_tenders_list
    organization_list = @tender.organization.complete_tenders rescue nil
    render json: organization_list
  end

  def similar_opportunities_tenders
    ids =  @tender.similar_opportunities.objects.limit(10).map(&:id).delete_if { |e| e == @tender.id }
    result = Core::Tender.where(id: ids)
    render json: result
  end

  def delete_favourite
    current_user.user_favourite_tenders.where(tender: @tender).delete_all

    render json: @tender, status: :ok
  end

  def add_favourite
    current_user.user_favourite_tenders.find_or_create_by tender: @tender

    render json: @tender, status: :ok
  end

  def my_favourites
    @favourite_tenders = current_user.favourite_tenders
    render json: @favourite_tenders
  end

  def bid_result
    render json: @tender.award_criteria_sections, each_serializer: TenderBidResultSerializer#, root: :tender_bidresult
  end

  def user_awaiting_result_tender
    users_status = ::Marketplace::UserTenderStatus.where(tender_id: @tender.id, collaboration_id: params[:collaboration_id]).where.not(status: 'awaiting_result')
    users_status.each do |user|
      break if user.status == 'won_lost'
      user.update(status: 'awaiting_result')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  def bnb_params
    params.permit(:answer_id, :question_id)
  end

  # Only allow a trusted parameter "white list" through.
  def tender_params
    params.permit(
      :title, :description, :industry, :geography, :value_from,
      :value_to, :keywords, :submission_date, :dispatch_date, :questioning_deadline,
      :answering_deadline, contact_info: []
    )
  end

  def compete_params
    params.permit(:id)
  end
end
