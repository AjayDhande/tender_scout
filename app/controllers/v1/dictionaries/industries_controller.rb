class V1::Dictionaries::IndustriesController < ApplicationController
  before_action :set_industry, only: [:show, :update]

  def index
    render json: Industry.all
  end

  def create
    @industry = Industry.new(industry_params)

    if @industry.save
      render json: @industry, status: :created
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @industry
  end

  def update
    if @industry.update(industry_params)
      render json: nil, status: :ok
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @industry.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_industry
    @industry = Industry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def industry_params
    params.permit(:name)
  end

end
