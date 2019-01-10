class CreateCompeteAnswer
  include Interactor

  def call


    @tender = Core::Tender.find(context.params[:tender_id])
    unless @tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Tender not found'},
                    code: :unauthorized
    end
    @comment = CompeteComment.find(context.params[:id])
    unless @tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Comment not found'},
                    code: :unauthorized
    end

    context.answer = @comment.answers.new(answer_params)
    context.answer.user = context.user
    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def answer_params
    context.params.permit(:message, :parent_id)
  end
end