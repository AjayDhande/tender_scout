class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin?
  end

  def upgrade?
    @user.free? || @user.basic? || @user.standart?
  end

  def show?
    index?
  end

  def current?
    true
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

  def available_in_marketplace?
    true#!@user.free?
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
