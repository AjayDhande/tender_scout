module Assignable
  extend ActiveSupport::Concern

  included do
    def profile
      section = self.section
      return nil unless Current.user.present?
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id), user: Current.user.id).try(:first).try(:collaboration)
      self.assignments.where(collaboration: collaboration).first.user.profiles.first rescue nil
    end

    def assignment
      section = self.section
      return nil unless Current.user.present?
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id).ids, user: Current.user.id).first.collaboration
      self.assignments.where(collaboration: collaboration).first rescue nil
    end
  end
end