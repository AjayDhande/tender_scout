module CollaboratorTenderStatus

  def self.score(user:nil, tender: nil)
    if user.tenders.where(id: tender.id) == []
      nil
    else
     qualification_criteria_count = tender.qualification_criterias_count
     criteria_count = tender.award_criteries_count
     all_tender_qualification_criteria_answer_count = user.tender_qualification_criteria_answer_completed_count(tender)
     all_award_tender_criteria_answer_count = user.tender_award_criteria_answer_completed_count(tender)

    tender_complete_percent = 0
    needed_requirement = qualification_criteria_count + criteria_count
    done_requirement = all_tender_qualification_criteria_answer_count + all_award_tender_criteria_answer_count
    if needed_requirement == 0
      tender_complete_percent = 0
    else
     tender_complete_percent = (done_requirement.to_f/needed_requirement.to_f * 100).round(0)
    end
    tender_complete_percent
    end
  end

end