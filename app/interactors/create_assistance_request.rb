class CreateAssistanceRequest
  include Interactor

  def call
    unless context.user.valid_password?(context.params[:current_password])
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Wrong password'},
                    code: :unprocessable_entity
    end

    unless assistance_params[:assistance_type].present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Type is not provided'},
                    code: :unprocessable_entity
    end

    context.assistance = Assistance.new(assistance_params)
    context.assistance.user = context.user
    unless context.assistance.save
      context.fail! errors: context.assistance.errors,
                    code: :unprocessable_entity
    end
  end


  private

  def assistance_params
    context.params.permit(:assistance_type, :message)
  end

end