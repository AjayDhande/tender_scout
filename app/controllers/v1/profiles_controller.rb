class V1::ProfilesController < ApplicationController
  include ActionController::Serialization

  before_action :set_profile, only: [:show, :update, :destroy, :create_avatar, :destroy_avatar, :create_cover_img, :destroy_cover_img]
  before_action :set_user
  # after_action :verify_authorized

  # GET /profiles
  def index
    authorize Profile
    @profiles = ProfilePolicy::Scope.new(current_user, @user.profiles).resolve
    render json: @profiles
  end

  # GET /profiles/1
  def show
    authorize @profile
    render json: @profile
  end

  # POST /profiles
  def create
    authorize Profile
    result = CreateProfile.call(params: params, user: current_user)
    if result.success?
      render json: result.profile, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    authorize @profile
    result = UpdateProfile.call(profile: @profile, params: params, user: current_user)
    if result.success?
      render json: result.profile
    else
      render json: result.errors, status: result.code
    end
  end

  # DELETE /profiles/1
  def destroy
    # @profile.destroy
  end

  def create_avatar
    @profile.remove_avatar!
    @profile.save

    if @profile.update(avatar_params)
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def destroy_avatar
    @profile.remove_avatar!
    @profile.save
  end

  def create_cover_img
    @profile.remove_cover_img!
    @profile.save

    if @profie.update(cover_img_params)
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def destroy_cover_img
    @profile.remove_cover_img!
    @profile.save
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id]) rescue current_user
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.permit(
      :fullname, :display_name, :profile_type, :city, :timezone,
      :do_marketplace_available, :company_size, :turnover, :email,
      :industry_id, :country_id, :contacts, :valueFrom, :valueTo,
      :tender_level, :number_public_contracts, :company, :description,
      keywords: [], countries: [], industries: [], profile_type: []
    )
  end

  def avatar_params
    params.permit(:avatar)
  end

  def cover_img_params
    params.permit(:cover_img)
  end
end
