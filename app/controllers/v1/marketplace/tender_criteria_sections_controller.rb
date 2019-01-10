class V1::Marketplace::TenderCriteriaSectionsController < ApplicationController
  before_action :set_marketplace_tender_criteria_section, only: [:show, :update, :destroy]
  before_action :set_tender
  after_action :verify_authorized
  # GET /marketplace/tender_criteria_sections
  def index
    @marketplace_tender_criteria_sections = @tender.criteria_sections

    render json: @marketplace_tender_criteria_sections
  end

  # GET /marketplace/tender_criteria_sections/1
  def show
    render json: @marketplace_tender_criteria_section
  end

  def bulk_create
    result = BulkCreateCriteriaSections.call(params: params, tender: @tender)
    if result.success?
      render json: nil, status: :created
    else
      render json: result.errors, status: result.code
    end
  end
  # POST /marketplace/tender_criteria_sections
  def create
    @marketplace_tender_criteria_section = @tender.criteria_sections.new(marketplace_tender_criteria_section_params)

    if @marketplace_tender_criteria_section.save
      render json: @marketplace_tender_criteria_section, status: :created
    else
      render json: @marketplace_tender_criteria_section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_criteria_sections/1
  def update
    if @marketplace_tender_criteria_section.update(marketplace_tender_criteria_section_params)
      render json: @marketplace_tender_criteria_section
    else
      render json: @marketplace_tender_criteria_section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_criteria_sections/1
  def destroy
    @marketplace_tender_criteria_section.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_criteria_section
      @marketplace_tender_criteria_section = ::Marketplace::TenderCriteriaSection.find(params[:id])
    end

    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_criteria_section_params
      params.permit(:order, :title, :tender_id)
    end
end
