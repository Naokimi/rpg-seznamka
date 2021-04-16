class GroupsController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_group, only: %i[show edit update destroy]

  def index
    groups = policy_scope(Group)
    @groups = if params[:genre_ids]
                groups.includes(rulebook: :pairings).where(pairings: { genre_id: params[:genre_ids] })
              else
                groups
              end

    # the `geocoded` scope filters only groups with coordinates (latitude & longitude)
    # TODO talk about updating the groups table with
    # @markers = @groups.geocoded.map do |group|
    #   {
    #     lat: group.latitude,
    #     lng: group.longitude,
    #     infoWindow: render_to_string(partial: "info_window", locals: { group: group }),
    #     image_url: helpers.asset_url('REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS')
    #   }
    # end
  end

  def show
    @availability = helpers.availability_to_rows(@group.session_times)
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    group = Group.new(group_params)
    group.gm = @user
    authorize group
    if group.save
      redirect_to group_path(group)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_params
    params.require(:group).permit(:name, :description, :train_station, :rulebook_id)
  end
end
