class SearchMonitorPolicy
  attr_reader :user, :monitor

  def initialize(user, monitor)
    @user = user
    @monitor = monitor
  end

  def index?
    true || @monitor.profile?
  end

  def show?
    @user.paid? || @monitor.profile?
  end

  def create?
    @user.standart? || @user.admin? || @user.basic?
  end

  def update?
    create? && !@monitor.profile?
  end

  def all_results?
    index?
  end

  def preview?
    index?
  end

  def all_monitor_result?
    index?
  end

  def profile_monitor_result?
    index?
  end

  def archive?
    index? && !@monitor.profile?
  end

  def share?
    index? && !@monitor.profile?
  end

  def result?
    index?
  end

  def export?
    index?
  end



  def destroy?
    @user.standart? && !@monitor.profile?
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
