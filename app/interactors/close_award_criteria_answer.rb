class CloseAwardCriteriaAnswer
  include Interactor

  def call
    tender = Core::Tender.find(answer_params[:tender_id])
    award_criteria_answer = Marketplace::TenderAwardCriteriaAnswer.find(close_params[:id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end
    if tender.tender_collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end

    unless award_criteria_answer.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Award Criteria not found'},
                    code: :unprocessable_entity
    end

    if award_criteria_answer.closed
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Award Criteria is closed'},
                    code: :unprocessable_entity
    end

    context.answer = award_criteria_answer
    context.answer.closed = true

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def close_params
    context.params.permit( :id, :closed)
  end

  def answer_params
    context.params.permit(:tender_id)
  end
end