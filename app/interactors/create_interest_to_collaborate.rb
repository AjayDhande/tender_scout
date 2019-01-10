class CreateInterestToCollaborate
  include Interactor

  def call
    unless context.user.valid_password?(context.params[:current_password])
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Wrong password'},
                    code: :ok
    end

    tender = Core::Tender.where(id: interest_params[:tender_id]).first
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end
    if tender.tender_collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end
    unless interest_params[:message].present? || interest_params[:is_public].present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Fill in required fields'},
                    code: :unprocessable_entity
    end
    context.interest = context.user.collaboration_interests.new(interest_params)
    context.tender = tender
    unless context.interest.save
      context.fail! errors: context.interest.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def interest_params
    context.params.permit(:message, :is_public, :tender_id)
  end
end