class Core::TenderPolicy
  attr_reader :user, :tender

  def initialize(user, tender)
    @user = user
    @tender = tender
  end

  def index?
    @user.paid?
  end

  def show?
    true
    #@user.paid? || @user.tender_collaborators.map(&:collaboration).map(&:tender).include?(tender)
  end

  def create?
    @user.admin? #TODO clarify
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def get_bnb_data?
    @user.admin? || @user.standart?
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
