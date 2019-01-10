# original model source: apps/domain-core/domain/tenders/domain/tender.rb
class Core::Tender < ApplicationRecord
  include Pageable
  update_index('tenders#tender') { self }

  self.table_name = "core_tenders"

  belongs_to :currency, optional: true
  belongs_to :organization, optional: true
  belongs_to :procedure, optional: true
  belongs_to :classification, class_name: 'Core::ClassificationCode', foreign_key: :classification_code_id, optional: true
  has_one :country, through: :organization
  has_many :documents
  has_many :additional_information
  has_many :awards
  has_many :tender_contacts
  has_many :contacts, through: :tender_contacts
  # has_and_belongs_to_many :cpvs, join_table: 'core_tenders_cpvs', foreign_key: :tender_id, association_foreign_key: :cpv_id
  has_many :tender_cpvs
  has_many :cpvs, through: :tender_cpvs
  has_many :tender_naicses, class_name: 'TenderNaics'
  has_many :naicses, through: :tender_naicses, source: 'naics'
  has_many :tender_ngips
  has_many :ngips, through: :tender_ngips
  has_many :tender_unspsces, class_name: 'TenderUnspsc'
  has_many :unspsces, through: :tender_unspsces, source: 'unspsc'
  has_many :tender_gsins
  has_many :gsins, through: :tender_gsins
  has_many :tender_categories
  has_many :categories, through: :tender_categories
  has_many :tender_nhs_e_classes
  has_many :nhs_e_classes, through: :tender_nhs_e_classes
  has_many :tender_pro_classes
  has_many :pro_classes, through: :tender_pro_classes
  has_and_belongs_to_many :attachments
  has_many :team_members, through: :tender_committees, source: :user, class_name: 'User'
  has_many :qualification_criteria_sections, class_name: 'Marketplace::TenderQualificationCriteriaSection'
  has_many :qualification_criterias, class_name: 'Marketplace::TenderQualificationCriteria'
  has_many :criteria_sections, class_name: 'Marketplace::TenderCriteriaSection'
  has_many :criteries, class_name: 'Marketplace::TenderCriterium'
  has_many :award_criteria_sections, class_name: 'Marketplace::TenderAwardCriteriaSection'
  has_many :award_criteries, class_name: 'Marketplace::TenderAwardCriterium', through: :award_criteria_sections
  has_many :bid_no_bid_questions, class_name: 'Marketplace::BidNoBidQuestion'
  has_many :bid_no_bid_answers, through: :bid_no_bid_questions, class_name: 'Marketplace::BidNoBidAnswer'
  has_many :bid_no_bid_compete_answers, class_name: 'Marketplace::Compete::BidNoBidAnswer'
  has_many :bidsense_results
  has_many :collaboration_interests
  has_many :collaborations, class_name: 'Marketplace::Collaboration'
  has_many :qualification_criteria_answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer'
  has_many :award_criteria_answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer'
  has_many :tender_collaborators, through: :collaborations, class_name: 'Marketplace::TenderCollaborator'
  has_many :tender_collaboration_documents
  belongs_to :industry, optional: true
  belongs_to :creator, class_name: 'User', optional: true
  has_and_belongs_to_many :buyers, class_name: 'User'
  has_many :user_favourite_tenders
  enum status: [:created, :open, :archived]

  scope :active, -> { active_on(DateTime.now) }
  scope :active_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].gt(date)) }
  scope :inactive, -> { inactive_on(DateTime.now) }
  scope :inactive_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].lt(date)) }

  after_save :recalculate_bidsense

  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }
  #validates
  validate :q_and_a_deadlines
  validate :q_and_a_later_dispatch
  scope :with_relations, -> do
    relations = [:cpvs, :naicses, :ngips, :unspsces, :gsins, :nhs_e_classes, :pro_classes, :country, organization:[:country] ]
    includes(relations).references(*relations)
  end

  def status
    if self.awarded_on
      :awarded
    elsif self.cancelled_on
      :cancelled
    elsif self.submission_date && self.submission_date > Time.now
      :open
    else
      :closed
    end
  end

  def matched_competitor_bidsense
    self.bidsense_results.where('average_score > ?', 0.6)
  end

  def qualification_criterias_count
    self.qualification_criterias.count
  end

  def award_criteries_count
    self.award_criteries.count
  end

  def create_qa
    if self.bid_no_bid_questions.count == 0
      ActiveRecord::Base.transaction do
        (1..8).each do |question_num|
          question_name = "Question #{question_num}"
          question = self.bid_no_bid_questions.create!({question_text: question_name, position: question_num})
          (1..5).each do |ans_num|
            answer_name = "Answer #{ans_num}"
            question.bid_no_bid_answers.create!({ answer_text: answer_name, position: ans_num } )
          end
        end
      end
    end
  end

  def get_bnb_data
    data = []
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: self), user: Current.user).try(:first).try(:collaboration).try(:id)
    Marketplace::BidNoBidQuestion.all.each do |question|
      assigned_user_id = question.assignments.where(collaboration_id: collaboration).try(:first).try(:user_id)
      profile = User.where(id: assigned_user_id).try(:first).try(:profiles).try(:first)
      _tmp = {}
      answers = question.bid_no_bid_answers.map do |e|
        {
          id: e.id,
          answer_text: e.answer_text,
          order: e.order
        }
      end
      answered = self.bid_no_bid_compete_answers.where(bid_no_bid_question: question).map do |e|
        {
          id: e.id,
          user_id: e.user.id,
          answer_id: e.bid_no_bid_answer.id,
          answer_text: e.bid_no_bid_answer.answer_text,
          created_at: e.created_at,
          order: e.bid_no_bid_answer.order,
          weight: e.bid_no_bid_answer.weight
        }
      end
      _tmp[:question] = {
        id: question.id,
        question_text: question.question_text,
        title: question.title,
        available_answers: answers,
        answered: answered,
        assigment_profile: profile
      }
      data << _tmp
    end
    data
  end

  def process_bnb_data(params, current_user)
    # byebug

  end

  def self.search(tender_title: nil, tender_keywords: nil, tender_value_from: nil, tender_value_to: nil,
                  tender_countries: nil, tender_buyers: nil, tender_statuses: [], tender_sort: {},
                  tender_submission_date_from: nil, tender_submission_date_to: nil)

    matches = []
    if tender_value_to
      matches <<  {
                    range:
                    {
                      high_value:
                      {
                       lte: tender_value_to
                      }
                    }
                  } 
    end
    if tender_buyers
      matches << {
                    match: {
                      buyers:{
                            query: tender_buyers,
                            analyzer: :fullname,
                            operator: :and
                            # prefix: 1
                          }
                      }
                    } 
    end

    if tender_submission_date_from
      matches << {
                  range:
                  {
                    submission_date:
                    {
                      gte: tender_submission_date_from
                    }
                  }
                } 
    end

    if tender_submission_date_to
      matches << {
                  range:
                  {
                    submission_date:
                    {
                      lte: tender_submission_date_to
                    }
                  }
                } 
    end

    if tender_value_from
      matches << {
                    range:
                    {
                      low_value:
                      {
                        gte: tender_value_from
                      }
                    }
                  } 
    end
    unless tender_title.blank?
      matches << {
                    bool: 
                    {
                      should:[
                      { 
                        term:
                        {
                          title: 
                          {
                            value: tender_title,
                            boost: 2.5
                          }
                        }
                      }, {
                        match_phrase:
                        {
                          title: {
                            query: tender_title,
                            boost: 1.8
                          }
                        }
                      },
                      { 
                        term:
                        {
                          description: 
                          {
                            value: tender_title,
                            boost: 2.0
                          }
                        }
                      }, {
                        match_phrase:
                        {
                          description: 
                          {
                            query: tender_title,
                            boost: 1.7
                          }
                        }
                      }]
                    }
                  } 
    end

    if tender_keywords
      match_keywords = []
      tender_keywords.each do |e|
        match_keywords << {
          match:
          {
            description: {
              query: e,
              boost: 1.5
            }
          }
        }
      end
      matches << {
        bool: {
            should: match_keywords
          }
      }
    end

    if tender_countries
      match_countries = []
      tender_countries.each do |e|
        match_countries << {
          match:
          {
            country_id: e
          }
        }
      end
      matches << {
        bool: {
            should: match_countries
          }
      }
    end

    status_matches = []

    if tender_statuses  
      if tender_statuses.include? 'awarded'
        status_matches <<  {
              exists:
              {
                field: :awarded_on
              }
            } 
      end
      if tender_statuses.include? 'cancelled'
        status_matches <<  {
              exists:
              {
                field: :cancelled_on
              }
            } 
      end

      if tender_statuses.include? 'open'
        status_matches <<  {
                      range:
                      {
                        submission_date:
                        {
                         gt: DateTime.now
                        }
                      }
                    } 
      end

      if tender_statuses.include? 'closed'
        status_matches <<  {
                      range:
                      {
                        submission_date:
                        {
                         lte: DateTime.now
                        }
                      }
                    } 
      end
      matches << {
        bool: {
          should: status_matches
        }
      }

    end

    results = TendersIndex.query(matches)
    if tender_sort[:sort_by].present? and tender_sort[:sort_direction].present?
      results = results.order(
        tender_sort[:sort_by].to_sym => 
        {
          order: tender_sort[:sort_direction] 
        }
      )
    else
      results = results.order(created_at: { order: :desc })
    end
    results
  end

  def owner?(current_user)
    creator == current_user
  end

  ####################################################################################################
  # accessors for fields only accessible when the tender is loaded with_relations
  def additional_information_list
    self.additional_information.map{ |ai| { title: ai.title, url: ai.url } } rescue []
  end

  def documents_list
    self.documents.map { |d| { title: d.title, url: d.url } } rescue []
  end

  def procedure_name
    self.procedure.name rescue nil
  end

  def currency_name
      self.currency.name rescue nil
  end

  def currency_code
      self.currency.code rescue nil
  end

  def organization_name
     self.organization.name rescue nil
  end

  def organization_phone
      self.organization.phone rescue nil
  end

  def country_name
      self.organization.country.name rescue nil
  end

  def world_region
      self.organization.country.world_region rescue nil
  end

  def world_subregion
      self.organization.country.world_subregion rescue nil
  end

  def classification_code
      self.classification.code rescue nil
  end

  def classification_description
      self.classification.description rescue nil
  end

  def similar_opportunities
    result = nil
    matches = []
    if self.estimated_high_value.present?
      matches <<  {
          range:
              {
                  high_value:
                      {
                          lte: estimated_high_value.to_i
                      }
              }
      }
    end
    if self.estimated_low_value.present?
      matches << {
          range:
              {
                  low_value:
                      {
                          gte: self.estimated_low_value.to_i
                      }
              }
      }
    end
    if self.country.present?
      matches << {
          match:{
              country_id: self.country.id
          }
      }
    end
    if self.nuts_codes.present?
      match_nuts = []
      self.nuts_codes.each do |e|
        match_nuts << {
            match:{
                ic_nuts_codes: e
            }
        }
        matches << {
            bool: {
                should: match_nuts
            }
        }
      end
    end
    if self.cpvs.present?
      match_cpvs = []
      self.cpvs.each do |e|
        match_cpvs << {
            match:{
                ic_cpvs: e.id
            }
        }
        matches << {
            bool: {
                should: match_cpvs
            }
        }
      end
    end
    if self.naicses.present?
      match_naicses = []
      self.naicses.each do |e|
        match_naicses << {
            match:{
                ic_naicses: e.id
            }
        }
        matches << {
            bool: {
                should: match_naicses
            }
        }
      end
    end
    if self.ngips.present?
      match_ngips = []
      self.ngips.each do |e|
        match_ngips << {
            match:{
                ic_ngips: e.id
            }
        }
        matches << {
            bool: {
                should: match_ngips
            }
        }
      end
    end
    if self.unspsces.present?
      match_unspsces = []
      self.unspsces.each do |e|
        match_unspsces << {
            match:{
                ic_unspsces: e.id
            }
        }
        matches << {
            bool: {
                should: match_unspsces
            }
        }
      end
    end
    if self.gsins.present?
      match_gsins = []
      self.gsins.each do |e|
        match_gsins << {
            match:{
                ic_gsins: e.id
            }
        }
        matches << {
            bool: {
                should: match_gsins
            }
        }
      end
    end
    if self.nhs_e_classes.present?
      match_nhs_e_classes = []
      self.nhs_e_classes.each do |e|
        match_nhs_e_classes << {
            match:{
                ic_nhs_e_classes: e.id
            }
        }
        matches << {
            bool: {
                should: match_nhs_e_classes
            }
        }
      end
    end
    if self.pro_classes.present?
      match_pro_classes = []
      self.pro_classes.each do |e|
        match_pro_classes << {
            match:{
                ic_pro_classes: e.id
            }
        }
        matches << {
            bool: {
                should: match_pro_classes
            }
        }
      end
    end
    result = TendersIndex.query(matches)
  end

  def format_fields
    {
      origin_id:              id,
      title:                  title,
      description:            description,
      published_on:           published_on,
      submission_datetime:    submission_datetime,
      procedure_id:           procedure_id,
      currency_id:            currency_id,
      organization_id:        organization_id,
      main_activity:          main_activity,
      contract_category:      contract_category,
      location:               location,
      nuts_codes:             nuts_codes,
      estimated_value:        estimated_value.to_f,
      created_at:             created_at,
      updated_at:             updated_at,
      award_published_on:     award_published_on,
      awarded_at:             awarded_at,
      awarded_on:             awarded_on,
      cancelled_on:           cancelled_on,
      tender_urls:            tender_urls.map{ |url| { url: url } },
      award_urls:             award_urls,
      classification_code_id: classification_code_id,
      set_aside:              set_aside,
      archiving_policy:       archiving_policy,
      archive_date:           archive_date,
      place_of_performance:   place_of_performance,
      duration:               [[contract_duration_in_days, 'days'],
                               [contract_duration_in_months, 'months'],
                               [contract_duration_in_years, 'years']].find{ |d| !d[0].nil? }
    }
  end

  private
  def recalculate_bidsense
    Bidsense::RecalculateScoreJob.perform_later tender: self
  end

  def q_and_a_deadlines
    if questioning_deadline.present? && answering_deadline.present?
      if questioning_deadline > answering_deadline
        errors.add(:error, 'Questioning deadline must be earlier Answering deadline')
      end
    end
  end

  def q_and_a_later_dispatch
    if questioning_deadline.present? && answering_deadline.present? && dispatch_date.present?
      if dispatch_date > questioning_deadline
        errors.add(:error, 'Q&A deadlines must be earlier than dispatch date')
      end
    end
  end
end
