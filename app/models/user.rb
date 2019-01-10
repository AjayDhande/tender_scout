class User < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  include Pageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper, :confirmable, :registerable

  has_many :profiles
  has_many :search_monitors
  has_many :favourite_monitors
  has_many :tender_collaborators, class_name: 'Marketplace::TenderCollaborator'
  has_many :collaborations, through: :tender_collaborators
  has_many :tenders, through: :collaborations, source: :tender, class_name: 'Core::Tender'
  has_many :comments, class_name: 'CompeteComment'
  has_many :collaboration_interests
  has_many :tender_qualification_criteria_answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer'
  has_many :tender_award_criteria_answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer'
  has_many :assignments, :class_name => 'Marketplace::Assignment'
  has_many :user_favourite_tenders
  has_many :favourite_tenders, through: :user_favourite_tenders, source: :tender, class_name: 'Core::Tender'
  has_many :user_upgrade_requests, dependent: :destroy
  enum role: [:admin, :standart, :basic, :free]
  has_many :tender_status, class_name: 'Marketplace::UserTenderStatus'

  after_initialize :set_default_role, :if => :new_record?
  before_save :update_flags
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  def my_tender_list
    created_tenders = Core::Tender.where(creator: self).ids
    participant_tenders = tenders.ids
    result = Core::Tender.where(id: created_tenders + participant_tenders)
  end

  def collaboration_tenders_statistic
    percent_array_result = []
    result = {}
    tenders.each do |tender|
     qualification_criteria_count = tender.qualification_criterias_count
     criteria_count = tender.award_criteries_count
     all_tender_qualification_criteria_answer_count = tender_qualification_criteria_answer_completed_count(tender)
     all_tender_award_criteria_answer_count = tender_award_criteria_answer_completed_count(tender)
     tender_complete_percent = calculate_tender_complete_percent(qualification_criteria_count,criteria_count,
                                                               all_tender_qualification_criteria_answer_count,
                                                               all_tender_award_criteria_answer_count)
      percent_array_result<<tender_complete_percent
     result = user_tender_statuses(percent_array_result)
    end
    result
  end

  def paid?
    self.standart? || self.admin? || self.basic?
  end

  def has_collaboration_on_tender?(tender)
    self.tender_collaborators.map(&:collaboration).map(&:tender).include?(tender)
  end
  
  def tender_qualification_criteria_answer_completed_count(tender)
    collaboration =  Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: tender.id), user: self.id).first.collaboration
    Marketplace::TenderQualificationCriteriaAnswer.where(tender_id: tender.id, collaboration_id: collaboration.id).where(closed: true).uniq(&:tender_qualification_criteria_id).count
  end

  def update_flags
    if self.free?
      self.flags.delete('verified')
    else
      self.flags << 'verified'
    end
    self.flags.uniq!
  end

  def tender_award_criteria_answer_completed_count(tender)
    collaboration =  Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: tender.id), user: self.id).first.collaboration
    Marketplace::TenderAwardCriteriaAnswer.where(tender_id: tender.id, collaboration_id: collaboration.id).where(closed: true).uniq(&:tender_award_criteria_id).count
  end

  def calculate_tender_complete_percent(qualification_criteria_count,criteria_count,
                                       all_tender_qualification_criteria_answer_count,
                                       all_tender_award_criteria_answer_count)
    tender_complete_percent = 0
    needed_requirement = qualification_criteria_count + criteria_count
    done_requirement = all_tender_qualification_criteria_answer_count + all_tender_award_criteria_answer_count
    if needed_requirement == 0
      tender_complete_percent = 0
    else
      tender_complete_percent = (done_requirement.to_f/needed_requirement.to_f * 100).round(0)
    end
    tender_complete_percent
  end

  def user_tender_statuses(percent_array_result)
    count_all = percent_array_result.count
    if count_all > 0
    more_61  = 0
    more_31 = 0
    less_30 = 0
    done = 0
    status_result = {}
    percent_array_result.each do |tender|
      if tender == 100
        done +=1
      elsif tender > 61
        more_61 +=1
      elsif (31..60).include?(tender)
        more_31 +=1
      elsif  (0..30).include?(tender)
        less_30 +=1
      end
    end
   percent_done = done*100/count_all
   percent_more_61 = more_61*100/count_all
   percent_more_30 = more_31*100/count_all
   percent_less_30 = 100 - (percent_done + percent_more_61 + percent_more_30)

    status_result = { total: 100, complete: percent_done,
                      complete_61: percent_more_61, complete_31: percent_more_30,
                      complete_less_31: percent_less_30}
    else
      status_result = { total: 100, complete: 0,
                        complete_61: 0, complete_31: 0,
                        complete_less_31: 0}
      end
  end

  def send_confirmation_instructions
    unless @raw_confirmation_token
      generate_confirmation_token!
    end
    opts = pending_reconfirmation? ? { to: unconfirmed_email } : { }
    #send_devise_notification(:confirmation_instructions, @raw_confirmation_token, opts)
  end

  def set_default_role
    self.role ||= :free
  end

  def self.search(search_field)
    result = nil
    if search_field
      matches = []
      matches << { 
        match: { 
          buyers:{
            query: search_field,
            analyzer: :fullname_search,
            operator: :and,
            # prefix: 1
          } 
        }
      }
      matches << { 
        match: { 
          email: {
            query: search_field,
            analyzer: :fullname,
            operator: :and,
            # prefix: 1
          } 
        }
      }

      result = UsersIndex.query(
        bool: 
        { 
          should: matches 
        }
      )
    end
    result
  end
end
