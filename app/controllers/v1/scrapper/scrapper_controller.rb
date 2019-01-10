class V1::Scrapper::ScrapperController < ApplicationController

  def input
    parameters = params.to_unsafe_h
    unless parameters.empty?
      if parameters[:required] and parameters[:required].size > 0
        bulk_process(tenders: parameters[:required])
      else
        process_tender(tender_information: parameters)
      end
    end
    render json: nil, status: :ok
  end

  private

  def bulk_process(tenders: nil)
    tenders.each {|tender| process_tender(tender_information: tender)}
  end

  def process_tender(tender_information: nil)
    Core::Tender.transaction do
      tender_information = tender_information.symbolize_keys
      tender_hash = tender_information.slice(*tender_keys)
      tender_hash[:tender_urls] = [tender_hash[:tender_urls]] if tender_hash[:tender_urls].is_a?(String)
      tender_hash[:spider_id] = tender_hash[:origin_id]
      tender_hash[:submission_date] = tender_hash[:submission_datetime]
      tender_hash.delete(:origin_id)
      tender_hash.delete(:submission_datetime)
      tender_hash[:spider_id] = Digest::SHA512.hexdigest(tender_hash[:spider_id] + tender_hash[:tender_urls].first)

      org_hash = tender_information.slice(*organization_keys)

      organization = Core::Organization.find_or_initialize_by name: org_hash[:name]
      if organization.new_record?
        organization.country = Core::Country.find_by_name org_hash[:country_name]
        raise 'Invalid country!' unless a.country
        organization.save!
      end
      tender = Core::Tender.find_or_initialize_by(spider_id: tender_hash[:spider_id])
      tender.attributes = tender_hash
      tender.organization = organization
      tender.save!
    end
  end

  def organization_keys
    [:name, :country_name]
  end

  def tender_keys
    [:origin_id, :title, :description, :published_on, :submission_datetime, :tender_urls]
  end
end
