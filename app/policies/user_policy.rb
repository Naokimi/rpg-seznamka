class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    @user == @record
  end

  alias update? edit?
end
