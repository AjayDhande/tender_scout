class V1::CaseStudiesController < ApplicationController
  include ActionController::Serialization
  before_action :set_case_study, only: [:show, :update, :destroy, :remove_image]
  before_action :set_profile
  before_action :set_gallery_img, only: :remove_image
  after_action :verify_authorized, except: [:remove_image]

  def index
    authorize CaseStudy
    render json: @profile.case_studies
  end

  def show
    authorize @case_study
    render json: @case_study
  end

  def create
    authorize CaseStudy
    result = CreateCaseStudy.call(params: case_study_params, profile: @profile)
    if result.success?
      render json: result.case_study, status: :created
    else
      render json: result.errors, status: result.code
    end
  end


  def update
    authorize @case_study
    result = UpdateCaseStudy.call(params: case_study_params, profile: @profile, case_study: @case_study)
    if result.success?
      render json: result.case_study
    else
      render json: result.errors, status: result.code
    end
  end

  def destroy
    authorize @case_study
    @case_study.destroy
  end

  def remove_image
    @case_study.galleries.delete(@image)
    @image.remove_image!
    @image.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_case_study
    @case_study = CaseStudy.find(params[:id])
  end

  def set_gallery_img
    @image = Gallery.find(params[:image_id])
  end

  # Only allow a trusted parameter "white list" through.
  def case_study_params
    params.permit(
      :title, :description, :cover_img, :budget, :start_date,
      :delivery_date, video_list: [], gallery: [], industry_codes: []
    )
  end
end
