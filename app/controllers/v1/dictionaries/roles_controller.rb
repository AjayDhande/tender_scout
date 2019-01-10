class V1::Dictionaries::RolesController < ApplicationController
  before_action :set_role, only: [:show, :update]

  def index
    render json: Role.all

  end

  def create
    @role = Role.new(role_params)

    if @role.save
      render json: @role, status: :created
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @role
  end

  def update
    if @role.update(role_params)
      render json: nil, status: :ok
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.permit(:name, :description, :number)
  end

end
