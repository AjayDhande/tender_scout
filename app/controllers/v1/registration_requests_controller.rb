class V1::RegistrationRequestsController < ApplicationController
  before_action :set_request, only: [:show, :update]
  skip_before_action :authenticate_user!

  def index
    render json: RegistrationRequest.all
  end

  def create
    result = CreateRegistrationRequest.call(params: request_params)
    if result.success?
      render json: result.request, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end

  def update
    result = SignUpProcess.call(params: request_params, request: @request)
    if result.success?
      render json: result.request, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = RegistrationRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.permit(:fullname, :company, :company_size, :state,
      :city, :turnover, :tender_level, :win_rate, :email, :phone,
      :number_public_contracts, :do_use_automation, :do_use_collaboration,
      :do_use_bid_no_bid, :do_use_bid_library, :do_use_feedback, :do_collaborate,
      :tender_complete_time, :organisation_count, :industry_id, :country_id,
      markets: []
    )
  end
end