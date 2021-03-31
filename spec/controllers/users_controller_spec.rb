require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user)        { create(:user) }
  let(:second_user) { create(:user) }

  before do
    sign_in user
  end

  describe '#index' do
    before do
      create(:user, :with_preference)
    end

    it 'renders all users' do
      get :index
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@users).size).to eq(3)
    end

    it 'renders filtered users' do
      get :index, params: { genre_ids: Genre.all.pluck(:id) }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@users).size).to eq(1)
    end
  end

  describe '#show' do
    it 'renders a show page' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe '#edit' do
    it 'renders an edit page' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe '#update' do
    context 'success' do
      it 'updates the user and redirects' do
        patch :update, params: { id: user.id, user: { city: 'Test' } }
        expect(response).to redirect_to(user_path(user))
        expect(User.first.city).to eq('Test')
      end
    end

    context 'failure' do
      it 'redirects without updating' do
        patch :update, params: { id: user.id, user: { nickname: nil } }
        expect(response.status).to eq(302)
        expect(User.first).to eq(user)
      end
    end
  end
end
