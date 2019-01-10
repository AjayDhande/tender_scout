class UpdateProfile
  include Interactor

  def call
    unless context.user.admin? || context.profile.owner?(context.user)
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                    code: :unauthorized
    end

    if contact_params
      context.profile.contacts.destroy_all
      contact_params.each { |e| context.profile.contacts.create(contact_type: e[:contact_type], value: e[:value])}
    end
    ActiveRecord::Base.transaction do
      begin

    if keyword_params
      context.profile.keywords.destroy_all
      keyword_params.each { |e|
        keyword = Keyword.find_or_create_by(name: e)
        context.profile.keywords << keyword
      }
    end

    if value_params
      context.profile.valueFrom = value_params.first
      context.profile.valueTo = value_params.second
    end

    if country_params
      context.profile.countries.destroy_all
      country_params.each { |e|
        country = Core::Country.find_by_id(e)
        context.profile.countries << country if country.present?
      }
    end

    if industry_params
      context.profile.industries.destroy_all
      industry_params.each { |e|
        industry = Industry.find_by_id(e)
        context.profile.industries << industry if industry.present?
      }
    end

    if user_email_params
      context.user.email = user_email_params
      context.user.save
    end

    unless context.profile.update(profile_params)
      context.fail! errors: context.profile.errors,
                    code: :unprocessable_entity
    end
      rescue
        context.fail! errors: context.profile.errors,
                      code: :unprocessable_entity
      end
    end
  end

  private

  def profile_params
    context.params.permit(
      :fullname, :display_name, :profile_type, :city, :timezone,
      :do_marketplace_available, :company, :company_size, :turnover,
      :valueFrom, :valueTo, :tender_level, :number_public_contracts,
      :industry_id, :country_id, :description, profile_type: []
    )
  end

  def value_params
    context.params[:values]
  end

  def contact_params
    context.params[:contacts]
  end

  def keyword_params
    context.params[:keywords]
  end

  def country_params
    context.params[:countries]
  end

  def industry_params
    context.params[:industries]
  end
  def user_email_params
    context.params[:email]
  end
end