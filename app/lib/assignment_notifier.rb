module AssignmentNotifier

    def send_notice(assignment,criteria)
      user = User.find(assignment.user_id)
      profile = User.find(assignment.user_id).profiles.first
      tender = criteria.section.tender
      compete_status_url = TENDERSCOUTHOST + "/tenders/#{tender.id}/bid-status"
      CustomPostmarkMailer.template_email(
          user.email,
          Rails.configuration.mailer['templates']['assignment_invite'],
          {
              tender_name: tender.title,
              product_url: Rails.configuration.mailer['product_url'],
              user_name: profile.fullname,
              criteria_name: criteria.title,
              compete_status_url: compete_status_url,
              support_url: Rails.configuration.mailer['support'],
              company_name: Rails.configuration.mailer['company_name'],
              company_address: Rails.configuration.mailer['company_address']
        }
      ).deliver_later
    end

    def send_bnb_question_notice(assignment, collaboration, bnb_question)
      user = User.find(assignment.user_id)
      profile = User.find(assignment.user_id).profiles.first
      collaboration = Marketplace::Collaboration.find(collaboration)
      tender = collaboration.tender
      compete_status_url = TENDERSCOUTHOST + "/tenders/#{tender.id}/bid-status"
      CustomPostmarkMailer.template_email(
          user.email,
          Rails.configuration.mailer['templates']['assignment_invite'],
          {
              tender_name: tender.title,
              product_url: Rails.configuration.mailer['product_url'],
              user_name: profile.fullname,
              criteria_name: bnb_question.title,
              compete_status_url: compete_status_url,
              support_url: Rails.configuration.mailer['support'],
              company_name: Rails.configuration.mailer['company_name'],
              company_address: Rails.configuration.mailer['company_address']
          }
      ).deliver_later
    end

  end
