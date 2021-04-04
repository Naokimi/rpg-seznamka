class GroupPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    @user == @record.gm
  end

  alias update? edit?
  alias destroy? edit?

  alias new? show?
  alias create? show?
end
