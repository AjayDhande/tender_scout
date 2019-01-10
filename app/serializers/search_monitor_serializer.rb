class SearchMonitorSerializer < ActiveModel::Serializer
  attributes :id, :title, :tenderTitle, :countryList, :keywordList, :valueFrom, :valueTo, :codeList, :buyer,
             :statusList, :is_archived, :status, :tenders_count, :submission_date_to, :submission_date_from, :monitor_type

  attribute(:is_favourite) { is_favourite_monitor?(object)}

  attribute(:export) { object.downloadable_export_url }

  def is_favourite_monitor?(monitor)
    current_user.favourite_monitors.where(search_monitor: monitor).any?
  end
end
