class GetCollaborations
  include Interactor

  def call
    tender = Core::Tender.where(id: index_params[:tender_id]).first
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    profiles = []
    context.results = []
    if index_params[:interest] and index_params[:interest] == 'true'
      profiles = tender.collaboration_interests.map(&:user).map(&:profiles).flatten
    else
      profiles = Profile.all
    end

    if index_params[:match] and index_params[:match] == 'true'
      profiles = BidsenseResult.where(tender: tender).where('average_score >= ?', 0.6).map(&:profile) & profiles
      profiles = Profile.where(id: profiles.map(&:id))
    end

    if index_params[:type] and index_params[:type] != 'all'
      profiles = profiles.where("profile_type @> ?", index_params[:type])
    end
    profiles.each { |item| context.results.push(item) }
    context.results = profiles
  end

  private

  def index_params
    context.params.permit(:match, :interest, :type, :tender_id)
  end

end