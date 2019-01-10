class SearchMonitor < ApplicationRecord
  include Pageable
  include Sortable
  attr_accessor :sort_by
  attr_accessor :sort_direction
  mount_uploader :export, MonitorExportUploader
  belongs_to :user

  enum monitor_type: [:profile, :personal, :common]
  
  def downloadable_export_url
    self.export.url(query: {"response-content-disposition" => "attachment;"})
  end

  def results(sort_by: nil, sort_direction: nil)
    Core::Tender.search(
        tender_title: tenderTitle,
        tender_keywords: keywordList,
        tender_value_from: valueFrom,
        tender_value_to: valueTo,
        tender_countries: countryList,
        tender_buyers: buyer,
        tender_statuses: status,
        tender_sort: {
          sort_by: sort_by,
          sort_direction: sort_direction
        }
    )
  end


end
