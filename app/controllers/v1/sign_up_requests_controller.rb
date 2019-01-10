class V1::SignUpRequestsController < ApplicationController
  include UserConfirmationNotifier
  before_action :set_request, only: [:show, :update]
  skip_before_action :authenticate_user!

  def index
    render json: SignUpRequest.all
  end

  def create
    industry = Industry.find_by(id: registration_request_params[:industry_id])
    unless industry.present?
     return render json: { error: :unprocessable_entity, error_description: 'Industry not found'},
                    code: :unprocessable_entity
    end
    country = Core::Country.find_by(id: registration_request_params[:country_id])
    unless country.present?
      return render json: { error: :unprocessable_entity, error_description: 'Country not found'},
                    code: :unprocessable_entity
    end
    @registration_request = SignUpRequest.new(registration_request_params)
    @registration_request.industry = industry
    @registration_request.country = country
    if @registration_request.save
      if User.exists?(email: registration_request_params[:email])
        return render json: {error: 'User already exists'}, status: :unprocessable_entity
      end
      @user = User.new(user_params)
      return render json: @user.errors, status: :unprocessable_entity unless @user.save
      @profile = @user.profiles.new(profile_params)
      @profile.country = country
      @profile.industry = industry
      return render json: @user.errors, status: :unprocessable_entity, code: :unprocessable_entity unless @profile.save
      @contacts =  @profile.contacts.new(contact_type: 'phone', value: contact_params[:phone])
      return render json: @user.errors, status: :unprocessable_entity, code: :unprocessable_entity unless @contacts.save
      send_confirmation(@user)
      render json: {messgage: 'Confirm your account in email'}
    else
      render json: @registration_request.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = SignUpRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.permit(:fullname, :company, :state, :password,
                  :city, :tender_level, :email, :phone,
                  :number_public_contracts, :tender_complete_time,
                  :organisation_count, :industry_id, :country_id,
                  markets: []
    )
  end

  def user_params
    params.permit(:email ,:password)
  end

  def profile_params
    params.permit(:fullname, :city, :tender_level, :number_public_contracts)
  end

  def contact_params
    params.permit(:phone)
  end

  def registration_request_params
    params.permit(
        :fullname, :company, :state,
        :city, :tender_level, :email, :phone,
        :number_public_contracts, :tender_complete_time,
        :organisation_count, :industry_id, :country_id,
        markets: []
    )
  end

end