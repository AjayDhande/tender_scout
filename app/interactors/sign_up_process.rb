class SignUpProcess
  include Interactor

  def call
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.update(do_processed: true)

    CustomPostmarkMailer.template_email(
      context.request.email,
      Rails.configuration.mailer['templates']['sign_up_process'],
      {
        user_name: context.request.fullname,
        product_url: Rails.configuration.mailer['product_url'],
        support_url: Rails.configuration.mailer['support'],
        company_name: Rails.configuration.mailer['company_name'],
        company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_later
  end
end
