class Marketplace::CollaborationPolicy < Core::TenderPolicy
  attr_reader :user, :collaboration

  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
  end
  
  def apply?
   @collaboration.tender.owner?(@user) || @collaboration.tender_collaborators.where(user: @user).try(:first).try(:role) ||
        @user.admin? || @user.standart?
  end

  def remove?
    apply?
  end 

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
