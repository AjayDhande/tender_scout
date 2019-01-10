class V1::Marketplace::TenderQualificationCriteriasController < ApplicationController
  include ActionController::Serialization
  before_action :set_marketplace_tender_qualification_criteria, only: [:show, :update, :destroy, :tender_qualification_criteria_comments,
                                                     :tender_qualification_criteria_notes, :update_deadline, :create_assign, :update_assign,
                                                     :delete_assign, :delete_files]
  before_action :set_tender
  after_action :verify_authorized, except: [:tender_qualification_criteria_comments, :tender_qualification_criteria_notes, :update_deadline,
                                            :create_assign, :update_assign, :delete_assign, :delete_files]
  # GET /marketplace/tender_qualification_criterias
  def index
    @marketplace_tender_qualification_criterias = @tender.qualification_criterias.all
    authorize @marketplace_tender_qualification_criterias
    render json: @marketplace_tender_qualification_criterias
  end

  # GET /marketplace/tender_qualification_criterias/1
  def show
    authorize @marketplace_tender_qualification_criteria
    render json: @marketplace_tender_qualification_criteria
  end

  # POST /marketplace/tender_qualification_criterias
  def create
    authorize ::Marketplace::TenderQualificationCriteria
    @marketplace_tender_qualification_criteria = @tender.qualification_criterias.new(marketplace_tender_qualification_criteria_params)

    if params[:attachments]
      params[:attachments].each do |k,v|
        attachment = Attachment.new(file: v)
        attachment.save
        @marketplace_tender_qualification_criteria.attachments << attachment
      end
    end

    if @marketplace_tender_qualification_criteria.save
      render json: @marketplace_tender_qualification_criteria, status: :created
    else
      render json: @marketplace_tender_qualification_criteria.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_qualification_criterias/1
  def update
    authorize @marketplace_tender_qualification_criteria
    if params[:attachments]
      params[:attachments].each do |k,v|
        attachment = Attachment.new(file: v)
        attachment.save
        @marketplace_tender_qualification_criteria.attachments << attachment
      end
    end
    if @marketplace_tender_qualification_criteria.update(marketplace_tender_qualification_criteria_params)
      render json: @marketplace_tender_qualification_criteria
    else
      render json: @marketplace_tender_qualification_criteria.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_qualification_criterias/1
  def destroy
    authorize @marketplace_tender_qualification_criteria
    @marketplace_tender_qualification_criteria.destroy
  end

  # Comments for TenderQualificationCriteria
  def tender_qualification_criteria_comments
    tender = @marketplace_tender_qualification_criteria.section.tender
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: tender), user: current_user.id)
    if collaboration.present?
    collaboration_profiles = collaboration.first.collaboration.users.map(&:profiles)
    profiles_ids = collaboration_profiles.map(&:ids).flatten
    profiles = @marketplace_tender_qualification_criteria.comments.where(profile_id: profiles_ids).map(&:profile).uniq
    comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_qualification_criteria.comments.where(profile_id: profiles_ids),
                                                                 each_serializer: CommentSerializer)

    else
      profiles = @marketplace_tender_qualification_criteria.comments.where(profile_id: current_user.profiles.first.id).map(&:profile)
      comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_qualification_criteria.comments.where(profile_id: current_user.profiles.first.id),
                                                                   each_serializer: CommentSerializer)
    end
    render json: { comments: comments, profiles: profiles }
  end

  # Notes for TenderQualificationCriteria
  def tender_qualification_criteria_notes
    profiles = @marketplace_tender_qualification_criteria.notes.where(profile_id: current_user.profiles.first.id).map(&:profile).uniq
    notes = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_qualification_criteria.notes.where(profile_id: current_user.profiles.first.id),
                                                              each_serializer: NoteSerializer)
    render json: { notes: notes, profiles: profiles }
  end

  #Update dedline
  def update_deadline
    if @marketplace_tender_qualification_criteria.update(deadline_params)
      render json: @marketplace_tender_qualification_criteria
    else
      render json: @marketplace_tender_qualification_criteria.errors, status: :unprocessable_entity
    end
  end

  def create_assign
    @assignment = @marketplace_tender_qualification_criteria.assignments.new(assignments_params)
    if @assignment.save
      render json: @assignment, status: :ok
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def update_assign
    @assignment = @marketplace_tender_qualification_criteria.assignment
    if @assignment.update(assignments_params)
      render json: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def delete_assign
    @marketplace_tender_qualification_criteria.assignment.destroy
  end

  def delete_files
    if params[:file_id].present?
      @marketplace_tender_qualification_criteria.attachments.where(id: params[:file_id]).each { |e| e.destroy }
    else
      @marketplace_tender_qualification_criteria.attachments.each { |e| e.destroy }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_qualification_criteria
      id = params[:tender_qualification_criteria_id] || params[:marketplace_tender_qualification_criteria_id] || params[:id]
      @marketplace_tender_qualification_criteria = ::Marketplace::TenderQualificationCriteria.find(id)
    end

    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_qualification_criteria_params
      params.permit(:order, :title, :weight,:description, :section_id, files: [])
    end

  def deadline_params
    params.permit(:deadline)
  end

  def assignments_params
    params.permit( :user_id, :collaboration_id)
  end
end
