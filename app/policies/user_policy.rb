class UserPolicy < ApplicationPolicy
  def show?
    @user == @record
  end

  alias edit? show?
  alias update? show?
end
