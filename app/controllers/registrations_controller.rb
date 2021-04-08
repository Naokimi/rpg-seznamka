class RegistrationsController < Devise::RegistrationsController
  def new
    @genres = Genre.all
    super
  end
end
