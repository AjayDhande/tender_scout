class SearchMonitor::MonitorExport < ApplicationJob
  require 'csv'
  require 'tempfile'
  queue_as :default

  def perform(monitor)
    results = monitor.results.page(1).per(1000).objects
    filename = Tempfile.new(SecureRandom.uuid).path + '.csv' #Rails.root.join('public') + SearchMonitor::MonitorExport.temp_name('monitor_export_', 'csv')
    header = ['Title', 'Description', 'Buyer','Low Value', 'High Value', 'Dispatch Date', 'Submission Date']
    CSV.open(filename, "wb") do |csv|
      csv << header
      results.each do |e|
        csv << [e.title,e.description,e.organization_name,e.estimated_low_value,e.estimated_high_value,e.dispatch_date,e.submission_date]
      end
    end
    send_file(monitor, filename)
  end

  def send_file(monitor, file)
    monitor.export = Pathname.new(file).open
    monitor.save!
    tokens = Doorkeeper::AccessToken.where(resource_owner_id: monitor.user.id).map(&:token) 
    tokens.each do |token|
      ActionCable.server.broadcast "search_export_#{token}_channel", monitor.downloadable_export_url
    end
  end

  def self.temp_name(file_name='', ext='', dir=nil)
    id   = Thread.current.hash * Time.now.to_i % 2**32
    name = "%s%d.%s" % [file_name, id, ext]
  end
end