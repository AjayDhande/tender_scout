class V1::Marketplace::TenderSuppliersController < ApplicationController
  before_action :set_tender
  before_action :set_supplier, only: [:destroy, :invite_approve]
  after_action :verify_authorized
  
  def index
    render json: Supplier.where(tender_id: params[:tender_id])
  end

  def create
    result = InviteSupplier.call(params: supplier_params, user: current_user, tender: @tender)
    if result.success?
      render json: result.supplier, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def destroy
    @supplier.destroy
  end

  def invite_approve
    @supplier.update(status: :approved)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:tender_id])
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  def supplier_params
    params.permit(:supplier)
  end
end
