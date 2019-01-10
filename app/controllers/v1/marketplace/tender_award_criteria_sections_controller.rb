class V1::Marketplace::TenderAwardCriteriaSectionsController < ApplicationController
  include UserTenderStatusChanger
  before_action :set_tender
  before_action :set_marketplace_tender_award_criteria_section, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:bulk_create]
  # GET /marketplace/tender_award_criteria_sections
  def index
    @marketplace_tender_award_criteria_sections = @tender.award_criteria_sections
    authorize @marketplace_tender_award_criteria_sections
    render json: @marketplace_tender_award_criteria_sections
  end

  # GET /marketplace/tender_award_criteria_sections/1
  def show
    authorize @marketplace_tender_award_criteria_section
    render json: @marketplace_tender_award_criteria_section
  end

  # POST /marketplace/tender_award_criteria_sections
  def create
    @marketplace_tender_award_criteria_section = @tender.award_criteria_sections.new(marketplace_tender_award_criteria_section_params)
    authorize @marketplace_tender_award_criteria_section
    if @marketplace_tender_award_criteria_section.save
      user_competing_tender(marketplace_tender_award_criteria_section_params[:tender_id],
                            marketplace_tender_award_criteria_section_params[:collaboration_id])
      render json: @marketplace_tender_award_criteria_section, status: :created
    else
      render json: @marketplace_tender_award_criteria_section.errors, status: :unprocessable_entity
    end
  end

  def bulk_create
    result = BulkCreateAwardCriteriaSections.call(params: params, tender: @tender)
    if result.success?
      render json: nil, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /marketplace/tender_award_criteria_sections/1
  def update
    authorize @marketplace_tender_award_criteria_section
    if @marketplace_tender_award_criteria_section.update(marketplace_tender_award_criteria_section_params)
      render json: @marketplace_tender_award_criteria_section
    else
      render json: @marketplace_tender_award_criteria_section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_award_criteria_sections/1
  def destroy
    authorize @marketplace_tender_award_criteria_section
    @marketplace_tender_award_criteria_section.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_award_criteria_section
      @marketplace_tender_award_criteria_section = ::Marketplace::TenderAwardCriteriaSection.find(params[:id])
    end

    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end


    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_award_criteria_section_params
      params.permit(:order, :title, :tender_id, :collaboration_id)
    end
end