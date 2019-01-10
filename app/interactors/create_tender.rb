class CreateTender
  include Interactor

  def call
    Core::Tender.transaction do
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                      code: :unauthorized unless context.user.admin?

      context.tender = Core::Tender.new(tender_params)
      context.tender.estimated_low_value = context.params[:value_from] if context.params[:value_from]
      context.tender.estimated_high_value = context.params[:value_to] if context.params[:value_to]
      context.tender.industry = Industry.find_by_id(industry_params[:industry]) if industry_params[:industry]
      context.tender.country = Core::Country.find_by_id(geography_params[:geography]) if geography_params[:geography]
      context.tender.creator = context.user
      context.fail! errors: context.tender.errors, code: :unprocessable_entity unless context.tender.save

      if contact_params and contact_params[:person] and contact_params[:email]
        contact = context.tender.contacts.new
        contact.contact_point = contact_params[:person]
        contact.email = contact_params[:email]
        context.fail! errors: contact.errors, code: :unprocessable_entity unless contact.save
        context.tender.tender_contacts.create! contact: contact
      end
    end
  end

  private

  def tender_params
    context.params.permit(
        :title, :description, :submission_date, :dispatch_date, :questioning_deadline, :answering_deadline, keywords: []
    )
  end

  def industry_params
    context.params.permit(:industry)
  end

  def geography_params
    context.params.permit(:geography)
  end

  def contact_params
    context.params[:contact_info]
  end

end