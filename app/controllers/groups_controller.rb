class GroupsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @groups = Group.all

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


  def group_params
    params.require(:group).permit(:name, :description, :city)
  end

end
