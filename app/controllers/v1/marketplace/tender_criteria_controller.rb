class V1::Marketplace::TenderCriteriaController < ApplicationController
  before_action :set_marketplace_tender_criterium, only: [:show, :update, :destroy]
  before_action :set_tender

  # GET /marketplace/tender_criteria
  def index
    @marketplace_tender_criteria = @tender.criteries.all

    render json: @marketplace_tender_criteria
  end

  # GET /marketplace/tender_criteria/1
  def show
    render json: @marketplace_tender_criterium
  end

  # POST /marketplace/tender_criteria
  def create
    @marketplace_tender_criterium = @tender.criteries.new(marketplace_tender_criterium_params)

    if @marketplace_tender_criterium.save
      render json: @marketplace_tender_criterium, status: :created
    else
      render json: @marketplace_tender_criterium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_criteria/1
  def update
    if @marketplace_tender_criterium.update(marketplace_tender_criterium_params)
      render json: @marketplace_tender_criterium
    else
      render json: @marketplace_tender_criterium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_criteria/1
  def destroy
    @marketplace_tender_criterium.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_criterium
      @marketplace_tender_criterium = ::Marketplace::TenderCriterium.find(params[:id])
    end

    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_criterium_params
      params.permit(:order, :title, :description, :section_id, :parent_id)
    end
end
