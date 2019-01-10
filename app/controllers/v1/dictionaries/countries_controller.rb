class V1::Dictionaries::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :update]

  def index
    render json: Core::Country.all
  end

  def create
    @country = Core::Country.new(country_params)

    if @country.save
      render json: nil, status: :created
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @country
  end

  def update
    if @country.update(country_params)
      render json: nil, status: :ok
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Core::Country.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.permit(:code, :number, :alpha2code, :alpha3code, :name, :world_region, :world_subregion, :other_names)
  end
end
