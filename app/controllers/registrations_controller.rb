class RegistrationsController < Devise::RegistrationsController
  def new
    @genres = Genre.all
    @availability = { monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: [] }
    super
  end
end
