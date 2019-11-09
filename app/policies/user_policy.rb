class UserPolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def show?
    user.admin?
  end

  def bookmark?
    user.student?
  end

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin? || record.id == user.id
  end
end
