class V1::Dictionaries::IndustryCodesController < ApplicationController
  before_action :set_industry, only: [:create, :show, :update]
  before_action :set_industry_code, only: [:show, :update]

  def index
    render json: IndustryCode.all
  end

  def all_codes
    if codes_params[:codes]
      results = IndustryCode.search_codes(codes_params[:codes])
      count = results.count
      results = results.objects.page(paginate_params[:page]).per(paginate_params[:page_size])
      render json: {data: results, count: count}
    else
      render json: nil
    end
  end

  def create
    @industry_code = IndustryCode.find_or_create_by(
      industry: @industry,
      entity_code_name: industry_code_params[:entity_code_name],
      entity_code_id: industry_code_params[:entity_code_id]
    )

    if @industry_code.save
      render json: @industry_code, status: :created
    else
      render json: @industry_code.errors, status: :unprocessable_entity
    end
  end

  # def create_array
  #   if @industry
  #     if codes_params
  #       codes_params.each do |code|
  #         @industry_code = IndustryCode.new(
  #           industry: @industry,
  #           entity_code_name: code[:entity_code_name],
  #           entity_code_id: code[:entity_code_id]
  #         )
  #       end
  #     end
  #   end
  # end

  def show
    render json: @industry_code
  end

  def update
    if @industry_code.update(industry_code_params)
      render json: nil, status: :ok
    else
      render json: @industry_code.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @industry_code.destroy
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_industry
    @industry = Industry.find(params[:industry_id])
  end

  def codes_params
    params.permit(:codes)
  end

  def set_industry_code
    @industry_code = IndustryCode.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def industry_code_params
    params.permit(:entity_code_name, :entity_code_id)
  end

end
