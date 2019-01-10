class CreateCaseStudy
  include Interactor

  def call
    unless context.profile.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Profile not found'},
                    code: :unprocessable_entity
    end

    context.case_study = context.profile.case_studies.new(case_study_params)
    unless context.case_study.save
      context.fail! errors: context.case_study.errors,
                    code: :unprocessable_entity
    end

    if industry_codes_params
      context.case_study.industry_codes.destroy_all
      industry_codes_params.each { |e|
        code = IndustryCode.find(e)
        context.case_study.industry_codes << code if code.present?
      }
    end

    if gallery_params
      gallery_params.each do |file|
        file = Gallery.new(image: file)
        context.case_study.galleries << file if file.present?
      end
    end

    if video_params
      video_params.each do |video|
        context.case_study.video_list.push(video)
      end
    end
  end

  private

  def case_study_params
    context.params.permit(
        :title, :description, :cover_img, :budget, :start_date,
        :delivery_date, :video_list, :gallery, :industry_codes
    )
  end

  def industry_codes_params
    context.params[:industry_codes]
  end

  def gallery_params
    context.params[:gallery]
  end

  def video_params
    context.params[:video_list]
  end
end