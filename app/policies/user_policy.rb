class UserPolicy < ApplicationPolicy
  
  # only show admin page if admin user
  def create?
    user.admin?
  end

  def index?
    user.admin?
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
