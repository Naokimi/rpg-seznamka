require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  # before do
  #   sign_in user
  # end

  describe '#show' do
    it 'renders a show page' do
      get user_path(user)
      expect(response).to be_successful
      expect(assigns[:user]).to eq(user)
      expect(response).to render_template('show')
    end
  end

  describe '#edit' do

  end

  describe '#update' do

  end
end
