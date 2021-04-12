class RegistrationsController < Devise::RegistrationsController
  def new
    @genres = Genre.all
    @availability = { monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: [] }
    super
  end

  def create
    # copy-pasted from Devise's controller except for marked lines
    parse_genres # <=
    parse_availability # <=
    build_resource(sign_up_params)
    resource.genres = @user_genres # <=
    resource.availability = @user_availability # <=

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def parse_genres
    # select the keys of all marked genres (their IDs) and turn them into integers
    genre_ids = params['genre_options'].select { |_k, v| v == '1' }.each_key.map(&:to_i)
    @user_genres = Genre.where(id: genre_ids)
  end

  def parse_availability
    # parameters return like
    # <ActionController::Parameters {"monday-0"=>"1", "monday-1"=>"0", "monday-2"=>"1", "monday-3"=>"1", ...}>
    # we select all keys with value "1" and add the use the "day-hour" key format for our availability
    @user_availability = { monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: [] }
    params['availability_options'].select { |_k, v| v == '1' }.each_key do |key|
      day, hour = key.split('-')
      @user_availability[day.to_sym] << hour.to_i
    end
  end
end
