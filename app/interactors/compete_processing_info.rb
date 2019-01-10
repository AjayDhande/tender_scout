class CompeteProcessingInfo
  include Interactor

  def call
    tender = Core::Tender.find(context.params[:id])
    unless tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Tender not found'},
                    code: :unauthorized
    end

    closed_criteria = TenderCriteriaAnswer.where(tender_id: tender.id)
                                          .where(closed: true)
                                          .where(user: context.user)
                                          .group(:tender_criteria_id)
                                          .count
    closed_qualification_criterias = TenderQualificationCriteriaAnswer.where(tender_id: tender.id)
                                   .where(closed: true)
                                   .where(user: context.user)
                                   .group(:tender_qualification_criteria_id)
                                   .count
    total_criteria = tender.criteries.count + tender.qualification_criterias.count

    context.complete = ((closed_criteria.length.to_f + closed_qualification_criterias.length) / total_criteria) * 100
  end
end