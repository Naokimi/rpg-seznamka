class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    users = policy_scope(User)
    @users = params[:genre_ids] ? users.includes(:preferences).where(preferences: { genre_id: params[:genre_ids] }) : users
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def profile; end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:availability, :train_station)
  end
end
