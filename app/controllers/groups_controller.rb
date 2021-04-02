class GroupsController < ApplicationController

  def index
    groups = policy_scope(Group)
    # TODO: uncomment and change this line when we have the groups:genres relation in place
    # @groups = if params[:genre_ids]
    #  groups.includes(rulebook: :rulebook_genres).where(rulebook_genres: { genre_id: params[:genre_ids] })
    # else
    #  groups
    # end
    @groups = groups

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

  private

  def group_params
    params.require(:group).permit(:name, :description, :city)
  end
end
