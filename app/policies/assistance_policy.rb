class AssistancePolicy < Core::TenderPolicy
  def initialize(user, assistance)
    @user = user
    @assistance = assistance
  end

  def create?
  @user.admin? || @user.standart? || @user.basic?
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
