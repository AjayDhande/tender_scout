class CollaborationInterestPolicy# < Marketplace::TenderCompetePolicy
  attr_reader :user, :collaboration_interest

  def initialize(user, collaboration_interest)
    @user = user
    @collaboration_interest = collaboration_interest
  end
  def index?
    @user.admin? || @user.standart? || @user.basic?
  end
  def show?
  index?
  end
  def create?
    index?
  end
  def update?
    index?
  end
  def destroy?
    index?
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
