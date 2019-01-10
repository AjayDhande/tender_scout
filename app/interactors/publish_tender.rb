class PublishTender
  include Interactor

  def call
    unless context.tender.owner?(context.user)
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                    code: :unauthorized
    end
    unless context.tender.title.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Title'},
                    code: :unprocessable_entity
    end
    unless context.tender.description.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Desription'},
                    code: :unprocessable_entity
    end
    unless context.tender.country.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Country'},
                    code: :unprocessable_entity
    end
    unless context.tender.industry.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Industry'},
                    code: :unprocessable_entity
    end
    unless context.tender.criteries.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'You should have at least one criteria'},
                    code: :unprocessable_entity
    end
    unless context.tender.awards.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'You should have at least one award'},
                    code: :unprocessable_entity
    end
    unless context.tender.submission_date.present? && context.tender.submission_date > DateTime.now
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Submission date is incorrect'},
                    code: :unprocessable_entity
    end
    unless context.tender.submission_date.present? &&
        context.tender.dispatch_date.present? &&
        context.tender.submission_date < context.tender.dispatch_date
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Dispatch date is incorrect'},
                    code: :unprocessable_entity
    end
    unless context.tender.contacts.first.present? && context.tender.contacts.first.contact_point.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Contact person is not specified'},
                    code: :unprocessable_entity
    end
    unless context.tender.contacts.first.present? && context.tender.contacts.first.email.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Contact email is not specified'},
                    code: :unprocessable_entity
    end

    context.fail! errors: context.tender.errors, code: :unprocessable_entity unless context.tender.update(status: :open)

    model = {
      user_name: '',
      product_url: Rails.configuration.mailer['product_url'],
      tender_name: context.tender.title,
      tender_id: context.tender.id,
      tender_management_url: Rails.configuration.mailer['tender_management_url'],
      support_url: Rails.configuration.mailer['support'],
      company_name: Rails.configuration.mailer['company_name'],
      company_address: Rails.configuration.mailer['company_address']
    }

    profile = context.tender.creator.profiles.find_by(profile_type: :consultant)
    model['user_name'] = profile.fullname if profile.present?

    unless profile.present?
      CustomPostmarkMailer.template_email(
        context.tender.creator.email,
        Rails.configuration.mailer['templates']['tender_publish'],
        model
      ).deliver_later
    end

    unless context.tender.collaborators.present?
      context.tender.collaborators.each do |user|
        profile = user.profiles.find_by(profile_type: :consultant)
        model['user_name'] = profile.fullname if profile.present?
        unless profile.present?
          CustomPostmarkMailer.template_email(
            user.email,
            Rails.configuration.mailer['templates']['tender_publish'],
            model
          ).deliver_later
        end
      end
    end
  end
end