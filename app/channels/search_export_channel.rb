class SearchExportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "search_export_#{params[:token]}_channel"
  end

  def unsubscribed
  end

  def send_message(data)

  end
end
