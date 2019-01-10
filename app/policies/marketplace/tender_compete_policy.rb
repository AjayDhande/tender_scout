class Marketplace::TenderCompetePolicy
  attr_reader :user, :tender

  def initialize(user, tender)
    @user = user
    @tender = tender
  end

  def index?
    @user.paid? || @user.has_collaboration_on_tender?(tender)
  end

  def show?
    @user.paid? || @user.has_collaboration_on_tender?(tender)
  end

  def close?
    create?
  end

  def create?
    @user.paid? || @user.has_collaboration_on_tender?(tender)
  end

  def update?
    @user.paid? || @user.has_collaboration_on_tender?(tender)
  end

  def destroy?
    @user.paid? || @user.has_collaboration_on_tender?(tender)
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
