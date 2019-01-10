class UpdateProfilePassword
  include Interactor

  def call
    unless password_params[:password].empty?
      unless context.user.valid_password?(password_params[:current_password])
        context.fail! errors: { error: :unprocessable_entity, error_description: 'Wrong password'},
                      code: :unprocessable_entity
      end
      unless password_params[:password] == password_params[:password_confirmation]
        context.fail! errors: { error: :unprocessable_entity, error_description: 'Passwords not equal'},
                      code: :unprocessable_entity
      end

      context.user.reset_password(password_params[:password], password_params[:password_confirmation])
      unless context.user.save
        context.fail! errors: context.user.errors,
                      code: :unprocessable_entity
      end
    end
  end

  private

  def password_params
    context.params.permit(:password, :password_confirmation, :current_password)
  end

end