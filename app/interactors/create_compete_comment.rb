class CreateCompeteComment
  include Interactor

  def call
    @tender = Core::Tender.find(params[:tender_id])
    unless @tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Tender not found'},
                    code: :unauthorized
    end

    context.comment = context.user.comments.new(params)
    unless context.comment.save
      context.fail! errors: context.comment.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def params
    context.params.permit(:message, :parent_id, :tender_id)
  end
end