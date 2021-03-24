class GroupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
    @groups = Group.all

    # the `geocoded` scope filters only groups with coordinates (latitude & longitude)
    @markers = @groups.geocoded.map do |group|
      {
        lat: group.latitude,
        lng: group.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { group: group })
      }
    end
  end


  def group_params
    params.require(:group).permit(:name, :description, :city)
  end

end
