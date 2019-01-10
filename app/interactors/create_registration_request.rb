class CreateRegistrationRequest
  include Interactor

  def call
    industry = Industry.find_by(id: params[:industry_id])
    unless industry.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Industry not found'},
                    code: :unprocessable_entity
    end
    country = Core::Country.find_by(id: params[:country_id])
    unless country.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Country not found'},
                    code: :unprocessable_entity
    end
    context.request = RegistrationRequest.new(params)
    context.request.do_processed = false
    context.request.industry = industry
    context.request.country = country

    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.save

    CustomPostmarkMailer.template_email(
        Rails.configuration.mailer['admin_email'],
        Rails.configuration.mailer['templates']['sign_up_request'],
        {
            user_name: context.request.fullname,
            product_url: Rails.configuration.mailer['product_url'],
            action_url: Rails.configuration.mailer['admin_url'] + Rails.configuration.mailer['uri']['admin_sign_up'],
            company_name: Rails.configuration.mailer['company_name'],
            company_address: Rails.configuration.mailer['company_address']
        }
    ).deliver_later
  end

  private

  def params
    context.params.permit(
        :fullname, :company, :company_size, :state,
        :city, :turnover, :tender_level, :win_rate, :email, :phone,
        :number_public_contracts, :do_use_automation, :do_use_collaboration,
        :do_use_bid_no_bid, :do_use_bid_library, :do_use_feedback, :do_collaborate,
        :tender_complete_time, :organisation_count, :industry_id, :country_id,
        markets: []
    )
  end
end
