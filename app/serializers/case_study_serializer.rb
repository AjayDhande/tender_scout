class CaseStudySerializer < ActiveModel::Serializer
  has_many :galleries
  has_many :industry_codes

  attributes :id, :title, :description, :cover_img, :budget, :start_date,
             :delivery_date, :video_list, :industry_codes, :galleries
end
