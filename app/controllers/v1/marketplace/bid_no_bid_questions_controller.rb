class V1::Marketplace::BidNoBidQuestionsController < ApplicationController
  include AssignmentNotifier
  before_action :set_marketplace_bid_no_bid_question, only: [:show, :update, :destroy, :bid_no_bid_question_comments,
                                                             :bid_no_bid_question_notes, :create_assign,
                                                             :update_assign, :delete_assign]

  # GET /marketplace/bid_no_bid_questions
  def index
    @marketplace_bid_no_bid_questions = ::Marketplace::BidNoBidQuestion.all

    render json: @marketplace_bid_no_bid_questions
  end

  # GET /marketplace/bid_no_bid_questions/1
  def show
    render json: @marketplace_bid_no_bid_question
  end

  # POST /marketplace/bid_no_bid_questions
  def create
    @marketplace_bid_no_bid_question = Marketplace::BidNoBidQuestion.new(marketplace_bid_no_bid_question_params)

    if @marketplace_bid_no_bid_question.save
      render json: @marketplace_bid_no_bid_question, status: :created, location: @marketplace_bid_no_bid_question
    else
      render json: @marketplace_bid_no_bid_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/bid_no_bid_questions/1
  def update
    if @marketplace_bid_no_bid_question.update(marketplace_bid_no_bid_question_params)
      render json: @marketplace_bid_no_bid_question
    else
      render json: @marketplace_bid_no_bid_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/bid_no_bid_questions/1
  def destroy
    @marketplace_bid_no_bid_question.destroy
  end

  # Comments for TenderQualificationCriteria
  def bid_no_bid_question_comments
    tender = Core::Tender.find(params[:tender_id])
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: tender), user: current_user.id)
    if collaboration.present?
    collaboration_profiles = collaboration.first.collaboration.users.map(&:profiles)
    profiles_ids = collaboration_profiles.map(&:ids).flatten
    profiles = @marketplace_bid_no_bid_question.comments.where(profile_id: profiles_ids).map(&:profile).uniq
    comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_bid_no_bid_question.comments.where(tender_id: params[:tender_id], profile_id: profiles_ids),
                                                                 each_serializer: CommentSerializer)
    else
      profiles = @marketplace_bid_no_bid_question.comments.where(profile_id: current_user.profiles.first.id).map(&:profile)
      comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_bid_no_bid_question.comments.where(tender_id: params[:tender_id], profile_id: current_user.profiles.first.id),
                                                                   each_serializer: CommentSerializer)
    end
    render json: { comments: comments, profiles: profiles }
  end

  # Notes for TenderQualificationCriteria
  def bid_no_bid_question_notes
    profiles = @marketplace_bid_no_bid_question.notes.where(profile_id: current_user.profiles.first.id).map(&:profile).uniq
    notes = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_bid_no_bid_question.notes.where(tender_id: params[:tender_id],
                                                                                                           profile_id: current_user.profiles.first.id),
                                                              each_serializer: NoteSerializer)
    render json: { notes: notes, profiles: profiles }
  end

  def create_assign
    role = Marketplace::TenderCollaborator.where(collaboration_id: assignments_params[:collaboration_id], user_id: current_user.id).first
    if role.admin? || role.owner?
    @assignment = @marketplace_bid_no_bid_question.assignments.new(assignments_params)
    if @assignment.save
      send_bnb_question_notice(@assignment, assignments_params[:collaboration_id], @marketplace_bid_no_bid_question)
      render json: @assignment, status: :ok
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
    else
      render json: {error: ['You can\'t assign to collaboration'] }, status: :unprocessable_entity
      end
  end

  def update_assign
    role = Marketplace::TenderCollaborator.where(collaboration_id: assignments_params[:collaboration_id], user_id: current_user.id).first
    if role.admin? || role.owner?
    @assignment = @marketplace_bid_no_bid_question.assignments.where(collaboration_id: assignments_params[:collaboration_id]).first
     if @assignment.update(assignments_params)
       send_bnb_question_notice(@assignment, assignments_params[:collaboration_id], @marketplace_bid_no_bid_question)
       render json: @assignment
     else
       render json: @assignment.errors, status: :unprocessable_entity
     end
    else
      render json: {error: ['You can\'t assign to collaboration'] }, status: :unprocessable_entity
    end
  end

  def delete_assign
    @marketplace_bid_no_bid_question.assignments.where(collaboration_id: assignments_params[:collaboration_id],
                                                       user_id: assignments_params[:user_id]).first.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_marketplace_bid_no_bid_question
    @marketplace_bid_no_bid_question = ::Marketplace::BidNoBidQuestion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def marketplace_bid_no_bid_question_params
    params.permit(:question_text, :position, :tender_id)
  end

  def assignments_params
    params.permit( :user_id, :collaboration_id)
  end
end
