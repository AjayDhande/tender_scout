module UserConfirmationNotifier

  def send_confirmation(user)
    profile_name = user.profiles.first.fullname
    #confirmation_url = request.base_url + '/users/confirmation?confirmation_token=' + user.confirmation_token
    confirmation_url = TENDERSCOUTHOST + '/auth/confirm/' + user.confirmation_token
    CustomPostmarkMailer.template_email(
        user.email,
        Rails.configuration.mailer['templates']['user_confirmation'],
        {
                    product_url: Rails.configuration.mailer['product_url'],
                    user_name: profile_name,
                    activation_link: confirmation_url,
                    support_url: Rails.configuration.mailer['support'],
                    company_name: Rails.configuration.mailer['company_name'],
                    company_address: Rails.configuration.mailer['company_address']
        }
    ).deliver_later
  end

end
