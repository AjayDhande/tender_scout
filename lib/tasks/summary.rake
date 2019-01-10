namespace :summary do
  desc "Send a summary email"
  task :email,  [:user_id] => [:environment] do |t, args|
    User.all.each do |user|
      p "Making results for user #{user.profiles.first.fullname}"
      monitors = user.search_monitors
      ids = []
      monitors.each do |e|
        ids += e.results.map {|e| e.attributes['id']} .map(&:to_i) 
      end
      ids.uniq!
      results = Core::Tender.where('created_at >= ?',(DateTime.now - 1.week)).where(id: ids).last(10)
      p "Found #{results.count} tenders"
      if results.count
        tenders = []
        results.each do |e| 
          tenders << { 
            title: e.title, 
            url: Rails.configuration.mailer['tender_details_url'] % {id: e.id}
          }  
        end
        CustomPostmarkMailer.template_email(
          user.email,
          Rails.configuration.mailer['templates']['summary_tenders'],
          {
            user_name: user.profiles.first.fullname,
            summary_day: DateTime.now.strftime('%m.%d.%Y'),
            all_results_url: Rails.configuration.mailer['all_results_url'],
            tenders: tenders,
            product_url: Rails.configuration.mailer['product_url'],
            support_url: Rails.configuration.mailer['support'],
            company_name: Rails.configuration.mailer['company_name'],
            company_address: Rails.configuration.mailer['company_address']
          }
        ).deliver_later
      else
        CustomPostmarkMailer.template_email(
          user.email,
          Rails.configuration.mailer['templates']['empty_summary_tenders'],
          {
            user_name: user.profiles.first.fullname,
            summary_day: DateTime.now.strftime('%m.%d.%Y'),
            product_url: Rails.configuration.mailer['product_url'],
            support_url: Rails.configuration.mailer['support'],
            company_name: Rails.configuration.mailer['company_name'],
            company_address: Rails.configuration.mailer['company_address']
          }
        ).deliver_later
      end
    end
  end
end
