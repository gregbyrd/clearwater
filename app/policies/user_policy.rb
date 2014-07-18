class UserPolicy < ApplicationPolicy
  def show?
    user.admin? || user == record
  end
  
  def create?
    user.admin?
  end

  def index?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
