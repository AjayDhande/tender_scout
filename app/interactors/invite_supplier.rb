class InviteSupplier
  include Interactor

  def call
    unless context.tender.owner?(context.user)
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                    code: :unauthorized
    end

    unless context.tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    user = User.find_by_email(context.params[:supplier])
    unless user.present?
      profile = Profile.find_by_fullname(context.params[:supplier])
      user = profile.user if profile.present?
    end

    unless user.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No user found'},
                    code: :unprocessable_entity
    end

    context.supplier = Supplier.new(
      status: :pending,
      tender: context.tender,
      user: user
    )

    unless context.supplier.save
      context.fail! errors: context.supplier.errors,
                    code: :unprocessable_entity
    end

    user_profile = context.supplier.user.profiles.find_by(profile_type: :consultant)
    inviter_profile = context.tender.creator.profiles.find_by(profile_type: :consultant)

    CustomPostmarkMailer.template_email(
      context.supplier.user.email,
      Rails.configuration.mailer['templates']['supplier_invite'],
      {
        user_name: user_profile.fullname,
        inviter_name: inviter_profile.fullname,
        tender_name: context.tender.title,
        tender_id: context.tender.id,
        tender_details_url: Rails.configuration.mailer['uri']['tender_details'],
        invite_link_url: Rails.configuration.mailer['domain'] + Rails.application.routes.url_helpers.url_for(
            controller: 'v1/marketplace/tender_suppliers',
            action: 'invite_approve',
            tender_id: context.tender.id,
            id: context.supplier.id,
            only_path: true
        ),
        product_url: Rails.configuration.mailer['product_url'],
        support_url: Rails.configuration.mailer['support'],
        company_name: Rails.configuration.mailer['company_name'],
        company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_later
  end
end