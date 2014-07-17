class FishDatePolicy < ApplicationPolicy
  
  def create?
    user.admin?
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
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
