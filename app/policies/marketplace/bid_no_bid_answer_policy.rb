class Marketplace::BidNoBidAnswerPolicy
  attr_reader :user, :bid_no_bid_answer
  def initialize(user, answer)
    @user = user
    @answer = answer
  end

  def index?
  @user.admin? || @user.standart?
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