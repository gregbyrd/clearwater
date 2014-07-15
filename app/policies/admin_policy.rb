class AdminPolicy < ApplicationPolicy
  
  # only show admin page if admin user
  def show?
    user.admin?
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
