class GenerateProfileMonitors < ActiveRecord::Migration[5.1]
  def up
  	User.all.each do |user|
  		profile = user.profiles.try(:first)
  		if profile
  			sm = user.search_monitors.find_or_initialize_by(monitor_type: :profile)
  			sm.title = 'Profile monitor'
  			sm.countryList = []
  			sm.countryList << profile.country.id if profile.country
  			sm.keywordList = profile.keywords.pluck :name
  			sm.valueFrom = profile.valueFrom
  			sm.valueTo = profile.valueTo
  			sm.monitor_type = :profile
  			sm.save
  		end
  	end
  end

  def down
	SearchMonitor.where(monitor_type: :profile).delete_all
  end
end
