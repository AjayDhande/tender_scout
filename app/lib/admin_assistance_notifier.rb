module AdminAssistanceNotifier

  def send_admin_assistance_notice(assistance_user)
    User.where(role: 'admin').each do |user|
      CustomPostmarkMailer.template_email(
          user.email,
          Rails.configuration.mailer['templates']['admin_assistance_notifier'],
          {
              user_name: assistance_user.profiles.first.fullname.present? ? assistance_user.profiles.first.fullname : 'Admin',
              product_url: Rails.configuration.mailer['product_url'],
              action_url: ADMINPANELHOST + "/#/users/assist-requests",
              company_name: Rails.configuration.mailer['company_name'],
              company_address: Rails.configuration.mailer['company_address']
          }
      ).deliver_later
    end
  end

end
