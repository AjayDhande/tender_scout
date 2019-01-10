class V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy, :comment_childrens]

  def create
    if Comment::COMMENT_MODEL.key?(params[:commentable_type])
      comment_model = Comment::COMMENT_MODEL[params[:commentable_type]]
    else
      render json: {error: 'Unvalid commentable type'}
      return false
    end
    @comment = Comment.new(comment_params)
    @comment.commentable_type = comment_model
    @comment.profile_id = current_user.profiles.first.id
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end

  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  def comment_childrens
   result =  @comment.childrens
    render json: result
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:body, :commentable_id, :commentable_type, :parent_id, :tender_id )
  end

end