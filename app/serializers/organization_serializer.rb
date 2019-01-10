class OrganizationSerializer < ActiveModel::Serializer
  attributes  :id, :name,:description, :profile_url, :web_url, :country_id ,:created_at ,:updated_at,
  :published_tenders_count, :awarded_tenders_count, :awards_count, :delta, :email,:address, :city_name, :phone, :fax,
  :region_id, :creator_id, :salesforce_id, :salesforce_number, :salesforce_source, :salesforce_revenue, :employees,
  :industry, :ownership, :rating, :sic_description, :sic_code, :salesforce_type, :ticker_symbol

end
