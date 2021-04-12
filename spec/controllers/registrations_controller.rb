require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#new' do
    it 'renders a new page' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create' do
    let(:genre) { create(:genre) }
    it 'creates a new user' do
      post :create, params: {
        user: { nickname: 'Test', email: 'test@test.test', password: 'secret' },
        genre_options: { genre.id => '1' },
        availability_options: { monday: '19' }
      }
      expect(response).to redirect_to(root_path)
      expect(User.first.nickname).to eq('Test')
      expect(User.first.genres).to eq([genre])
    end
  end
end
