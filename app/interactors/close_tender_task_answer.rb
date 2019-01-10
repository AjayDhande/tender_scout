class CloseTenderTaskAnswer
  include Interactor

  def call
    tender = Core::Tender.find(close_params[:tender_id])
    tender_task_answer = Marketplace::TenderTaskAnswer.find(close_params[:id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    if tender.tender_collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end
    task = Marketplace::TenderTask.find(close_params[:tender_task_id])
    unless task.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Task not found'},
                    code: :unprocessable_entity
    end

    if tender_task_answer.closed
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Task answer is already closed'},
                    code: :unprocessable_entity
    end

    context.answer = tender_task_answer
    context.answer.closed = true

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def close_params
    context.params.permit(:id, :close, :tender_id, :tender_task_id)
  end
end