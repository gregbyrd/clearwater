class SeasonPolicy < ApplicationPolicy
  
  # only admin can create/edit Season
  def create?
    user.admin?
  end
  def update?
    user.admin?
  end
  # only admin can look at Seasons
  def index?
    user.admin?
  end
  def show?
    user.admin?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
