class V1::UsersController < ApplicationController
  include ActionController::Serialization
  before_action :set_user, only: [:show, :update, :destroy, :change_user_role]
  after_action :verify_authorized, except: [:search, :user_tender_statistic, :update_password, :invites, :requests,
                                           :my_compete_tenders, :my_tenders, :invited_by_me, :change_user_role, :available_in_marketplace, :current]

  # GET /users
  def index
    authorize User
    users = User.all
    @users = users.my_paginate(paginate_params)

    render json: {count: users.count, data: ActiveModel::Serializer::CollectionSerializer.new(@users,
          each_serializer: UserSerializer, current_user: current_user)}
  end

  def available_in_marketplace
    authorize User
    unless current_user.free?
    users = Profile.where(do_marketplace_available: true).select(:user_id).distinct.map(&:user_id)
    users = User.where(id: users)
    users = users.my_paginate(paginate_params)
    render json: {count: users.count, data: ActiveModel::Serializer::CollectionSerializer.new(users, 
          each_serializer: UserSerializer, current_user: current_user)}
    else
      users = User.where(id: current_user.id)
      render json: {count: 1, data: ActiveModel::Serializer::CollectionSerializer.new(users,
                                                                                                each_serializer: UserSerializer, current_user: current_user)}
    end
    end

  def upgrade
    authorize current_user
    uur = current_user.user_upgrade_requests.new
    if uur.save
      render json: nil, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def my_tenders
    my_tenders = current_user.my_tender_list
    status = params[:status]
    my_tenders = my_tenders.where(status: status.to_sym) if Core::Tender.statuses.keys.include?(status)
    my_tenders = my_tenders.with_relations
    sort_field = params[:sort_field]
    sort_direction = params[:sort_direction]
    if (%w(desc asc).include?(sort_direction) and %w(created_at dispatch_date submission_date).include?(sort_field))
      my_tenders = my_tenders.order(sort_field.to_sym => sort_direction.to_sym)
    end
    render json: ActiveModel::Serializer::CollectionSerializer.new(my_tenders, 
      each_serializer: TenderSerializer, current_user: current_user)
  end

  # GET /users/1
  def show
    authorize @user
    render json: @user
  end

  def current
    authorize current_user
    render json: current_user
  end

  def search
    search_field = params[:query]
    results = User.search(search_field)
    count = results.count
    results = results.objects.page(paginate_params[:page]).per(paginate_params[:page_size])
    render json: {data: results, count: count}
  end

  def invites
    result = []
    user_as_collaborator = ::Marketplace::TenderCollaborator.where(user: current_user)
    status = params[:status] 
    collaborations = collaborations.where(status: status) if %w(active pending ignore).include?(status)
    user_as_collaborator.each do |tc|
      result << {
        collaboration: Marketplace::CollaborationSerializer.new(tc.collaboration),
        collaboration_role: tc.role,
        tender: tc.collaboration.tender,
        role: current_user.role,
        status: tc.status,
        user: (tc.invited_by_user ? UserSerializer.new(tc.invited_by_user) : nil)
      }
    end
    render json: result
  end

  def invited_by_me
    result = []
    user_as_collaborator = ::Marketplace::TenderCollaborator.where(invited_by_user: current_user)
    status = params[:status] 
    collaborations = collaborations.where(status: status) if %w(active pending ignore).include?(status)
    user_as_collaborator.each do |tc|
      result << {
        collaboration: tc.collaboration,
        collaboration_role: tc.role,
        tender: tc.collaboration.tender,
        role: current_user.role,
        status: tc.status,
        user: UserSerializer.new(tc.user),
        invited_at: tc.created_at
      }
    end
    render json: result
  end

  def requests
    result = []
    current_user.collaboration_interests.each do |collab|
      result << {
        collaboration: collab,
        tender: collab.tender,
        role: current_user.role,
        status: :pending
      }
    end
    render json: result
  end
  
  def user_tender_statistic
    result = current_user.collaboration_tenders_statistic
    render json: { user_id: current_user.id, data: result }
  end

  # POST /users
  def create
    result = true
    @user = User.new(user_params)
    authorize @user
    if @user.save
      @user.confirm
      profile = @user.profiles.new(profile_params)
      if profile.save
        render json: @user, status: :created
      else
        @user.destroy
        render json: profile.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize @user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    authorize @user
    @user.destroy
  end

  def update_password
    result = UpdateProfilePassword.call(params: password_params, user: current_user)
    if result.success?
      render status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  def my_compete_tenders
    result = current_user.tenders.uniq
    render json: result, status: :ok
  end

  def change_user_role
    if current_user.admin?
    if @user.update(role_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
    else
      render json: {error: 'You are not admin'}, status: 403
      end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.permit(:fullname, :display_name, :timezone)
  end

  def user_params
    params.permit(:email, :password, :role)
  end

  def password_params
    params.permit(:password, :password_confirmation, :current_password)
  end

  def role_params
    params.permit(:role)
  end
end
