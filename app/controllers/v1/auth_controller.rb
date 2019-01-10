class V1::AuthController < Doorkeeper::TokensController

  def create
    user = User.find_by(email: params[:username])
    if user && !user.confirmed?
      render json: { message: 'User is not confirmed' }, status: 401
      return false
      end

    if super == :ok

      print 'sign_zendesk'
      # byebug
    end
  end

  def logoff
    if doorkeeper_token
      doorkeeper_token.destroy
      render json: {}, status: :ok
    else
      render json: {}, status: 401
    end
  end

  def forget_password
    user = User.where(email: params[:email]).first
    send_reset_password_instructions(user) if user
    render json: nil, status: :ok
  end

  def reset_password
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    reset_token = params[:reset_password_token]
    user = User.with_reset_password_token(reset_token)
    if user
      if password == password_confirmation
        user.reset_password(password, password_confirmation)
        user.save
        render json: {
          name: 'successful',
          error: 'Password reset successfully'
        }, status: 200
      else
        render json: {
          name: 'passwords_not_equal',
          error: 'Password not equal with confirmation'
        }, status: 500
      end
    else
    render json: {
        name: 'invalid_token',
        error: 'Reset token is invalid'
      }, status: 500
    end
  end
  
  private
  def send_reset_password_instructions(user)
    user.send(:set_reset_password_token)
    token = user.reset_password_token
    CustomPostmarkMailer.template_email(
      user.email,
      Rails.configuration.mailer['templates']['password_reset'],
      {
        user_name: user.profiles.first.fullname,
        product_url: Rails.configuration.mailer['product_url'],
        support_url: Rails.configuration.mailer['support'],
        company_name: Rails.configuration.mailer['company_name'],
        reset_password_link: Rails.configuration.mailer['reset_password_link'] % {token: token},
        company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_later
  end
end