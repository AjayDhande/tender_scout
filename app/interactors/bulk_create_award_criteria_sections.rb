class BulkCreateAwardCriteriaSections
  include Interactor

  def call
    Marketplace::TenderAwardCriteriaSection.transaction do
      marketplace_tender_criteria_sections.each do |_, section|
        section_instance = context.tender.award_criteria_sections.new(title: section[:title], order: section[:order])
        section_instance.save!

        create_criteries(params: section, section: section_instance, parent: nil)
      end
    end
  end

  private

  def create_criteries(params: nil, section: nil, parent: nil)
    if params[:award_criteries]
      params[:award_criteries].each do |_, e|
        criteria = section.award_criteries.new(
          order: e[:order],
          title: e[:title],
          weight: e[:weight]
          )
        criteria.save!
        if e[:attachments]
          e[:attachments].each do |k,v|
            attachment = Attachment.new(file: v)
            attachment.save
            criteria.attachments << attachment
          end
        end
        create_criteries(params: e, section: section, parent: criteria) if e[:criteries]
      end
    end
  end

  def marketplace_tender_criteria_sections
    context.params.to_unsafe_h[:sections]
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title, :weight)
  end

  def marketplace_tender_criteria_params
    context.params.permit(:order, :title, :weight, :tender_id, criteries: [])
  end


end