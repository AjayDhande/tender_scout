class CreateTenderQualificationCriteriaAnswer
  include Interactor

  def call
    tender = Core::Tender.find(answer_params[:tender_id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end
    if tender.tender_collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end
    qualification_criteria = Marketplace::TenderQualificationCriteria.find_by_id qualification_criterias_params[:tender_qualification_criteria_id]
    unless qualification_criteria.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'QualificationCriteria not found'},
                    code: :unprocessable_entity
    end
    unless answer_params.keys.include?("pass_fail") || answer_params.keys.include?("score") || answer_params.keys.include?("closed")
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No answer provided'},
                    code: :unprocessable_entity
    end

    if qualification_criteria.answers.exists?(closed: true)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Answer is already closed'},
                    code: :unprocessable_entity
    end

    context.answer = qualification_criteria.answers.find_or_initialize_by(collaboration_id: answer_params[:collaboration_id],tender_id: answer_params[:tender_id],tender_qualification_criteria_id: qualification_criterias_params[:tender_qualification_criteria_id])
    context.answer.attributes = answer_params
    context.answer.user = context.user

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end

    unless tender.buyers.exists?(context.user.id)
      tender.buyers << context.user
    end
  end

  private

  def qualification_criterias_params
    context.params.permit(:tender_qualification_criteria_id)
  end

  def answer_params
    context.params.permit(:tender_id, :pass_fail, :score, :closed, :collaboration_id)
  end
end