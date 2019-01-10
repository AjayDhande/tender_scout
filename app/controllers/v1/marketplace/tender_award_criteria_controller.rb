class V1::Marketplace::TenderAwardCriteriaController < ApplicationController
  include AssignmentNotifier
  before_action :set_marketplace_tender_award_criterium, only: [:show, :update, :destroy, :tender_award_criteria_comments,
                                                                :tender_award_criteria_notes, :update_deadline,
                                                                :create_assign, :update_assign, :delete_assign, :delete_files]
  before_action :set_tender

  # GET /marketplace/tender_award_criteria
  def index
    @marketplace_tender_award_criteria = @tender.award_criteries

    render json: @marketplace_tender_award_criteria
  end

  # GET /marketplace/tender_award_criteria/1
  def show
    render json: @marketplace_tender_award_criterium
  end

  # POST /marketplace/tender_award_criteria
  def create
    @marketplace_tender_award_criterium = @tender.award_criteries.new(marketplace_tender_award_criterium_params)
    if params[:attachments]
      params[:attachments].each do |k,v|
        attachment = Attachment.new(file: v)
        attachment.save
        @marketplace_tender_award_criterium.attachments << attachment
      end
    end

    if @marketplace_tender_award_criterium.save
      render json: @marketplace_tender_award_criterium, status: :created
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_award_criteria/1
  def update
    if params[:attachments]
      params[:attachments].each do |k,v|
        attachment = Attachment.new(file: v)
        attachment.save
        @marketplace_tender_award_criterium.attachments << attachment
      end
    end
    if @marketplace_tender_award_criterium.update(marketplace_tender_award_criterium_params)
      render json: @marketplace_tender_award_criterium
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_award_criteria/1
  def destroy
    @marketplace_tender_award_criterium.destroy
  end

  # Comments for TenderAwardCriteries
  def tender_award_criteria_comments
    tender = @marketplace_tender_award_criterium.section.tender
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: tender), user: current_user.id)
    if collaboration.present?
    collaboration_profiles = collaboration.first.collaboration.users.map(&:profiles)
    profiles_ids = collaboration_profiles.map(&:ids).flatten
    profiles = @marketplace_tender_award_criterium.comments.where(profile_id: profiles_ids).map(&:profile).uniq
    comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_award_criterium.comments.where(profile_id: profiles_ids),
                                                                 each_serializer: CommentSerializer)
    else
      profiles = @marketplace_tender_award_criterium.comments.where(profile_id: current_user.profiles.first.id).map(&:profile)
      comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_award_criterium.comments.where(profile_id: current_user.profiles.first.id),
                                                                   each_serializer: CommentSerializer)
    end
    render json: { comments: comments, profiles: profiles }
  end

  # Notes for TenderAwardCriteries
  def tender_award_criteria_notes
    profiles = @marketplace_tender_award_criterium.notes.where(profile_id: current_user.profiles.first.id).map(&:profile).uniq
    notes = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_award_criterium.notes.where(profile_id: current_user.profiles.first.id),
                                                              each_serializer: NoteSerializer)
    render json: { notes: notes, profiles: profiles }
  end

  #Update dedline
  def update_deadline
    if @marketplace_tender_award_criterium.update(deadline_params)
      render json: @marketplace_tender_award_criterium
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  def create_assign
    @assignment = @marketplace_tender_award_criterium.assignments.new(assignments_params)
    if @assignment.save
      send_notice(@assignment, @marketplace_tender_award_criterium)
      render json: @assignment, status: :ok
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def update_assign
    @assignment = @marketplace_tender_award_criterium.assignment
    if @assignment.update(assignments_params)
      send_notice(@assignment, @marketplace_tender_award_criterium)
      render json: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def delete_files
    if params[:file_id].present?
      @marketplace_tender_award_criterium.attachments.where(id: params[:file_id]).each { |e| e.destroy }
    else
      @marketplace_tender_award_criterium.attachments.each { |e| e.destroy }
    end
  end


  def delete_assign
    @marketplace_tender_award_criterium.assignment.destroy
  end

  private
  def set_tender
    @tender = Core::Tender.find_by_id params[:tender_id]
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_marketplace_tender_award_criterium
    id = params[:id] || params[:marketplace_tender_award_criterium_id] || params[:tender_award_criterium_id]
    @marketplace_tender_award_criterium = ::Marketplace::TenderAwardCriterium.find(id)
  end

  # Only allow a trusted parameter "white list" through.
  def marketplace_tender_award_criterium_params
    params.permit(:order, :title, :description, :weight, :section_id, files: [])
  end

  def deadline_params
    params.permit(:deadline)
  end

  def assignments_params
    params.permit( :user_id, :collaboration_id)
  end
end
