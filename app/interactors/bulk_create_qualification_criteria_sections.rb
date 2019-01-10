class BulkCreateQualificationCriteriaSections
  include Interactor

  def call
    Marketplace::TenderQualificationCriteriaSection.transaction do
      marketplace_tender_qualification_criteria_sections.each do |_, section|
        section_instance = context.tender.qualification_criteria_sections.new(title: section[:title], order: section[:order])
        section_instance.save!

        create_criteries(params: section, section: section_instance)
      end
    end
  end

  private

  def create_criteries(params: nil, section: nil)

    params[:qualification_criterias].each do |_, e|
      criteria = section.qualification_criterias.new(
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
    end
  end

  def marketplace_tender_qualification_criteria_sections
    context.params.to_unsafe_h[:sections]
  end

  def marketplace_tender_qualification_criteria_section_params
    context.params.permit(:order, :title, :weight)
  end

  def marketplace_tender_qualification_criteria_params
    context.params.permit(:order, :title, :weight, :tender_id, qualification_criterias: [])
  end


end