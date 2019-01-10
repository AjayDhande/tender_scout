class V1::Users::UpgradeRequestsController < ApplicationController
	include ActionController::Serialization
	before_action :authenticate_user!
	before_action :set_user_upgrade_request, only: [:approve, :destroy]
	after_action :verify_authorized

  def index
  	authorize UserUpgradeRequest
  	render json: UserUpgradeRequest.all, each_serializer: ::Users::UpgradeRequestSerializer
  end

  def approve
  	authorize @uur
    @uur.upgraded_at = DateTime.now
		if @uur.save
		  render json: nil, status: :ok
		else
			render json: nil, status: :unprocessable_entity
		end
  end

  def destroy
  	authorize @uur
    if @uur.destroy
    	render json: nil, status: :ok
    else
    	render json: nil, status: :unprocessable_entity
    end
  end

  private
  def set_user_upgrade_request
  	@uur = UserUpgradeRequest.find(params[:id])
  end
end
