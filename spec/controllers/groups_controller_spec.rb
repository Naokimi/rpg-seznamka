require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user)   { create(:user) }
  let(:group)  { create(:group, gm: user) }
  let(:group2) { create(:group, name: 'second group', rulebook: create(:rulebook, :with_genre, name: 'second rulebook')) }

  before do
    sign_in user
  end

  describe '#index' do
    context 'unfiltered' do
      it 'render an index page' do
        group
        group2
        get :index
        expect(response).to be_successful
        expect(controller.instance_variable_get(:@groups).size).to eq(2)
      end
    end

    context 'filtered' do
      it 'render an index page' do
        group
        group2
        get :index, params: { genre_ids: group2.rulebook.genres.pluck(:id) }
        expect(response).to be_successful
        expect(controller.instance_variable_get(:@groups).size).to eq(1)
      end
    end
  end

  describe '#new' do
    it 'renders a new page' do
      get :new, params: { user_id: user.id }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@group)).to be_an_instance_of(Group)
    end
  end

  describe '#create' do
    context 'success' do
      it 'creates a new group' do
        post :create, params: {
          user_id: user.id,
          group: { name: 'test group', city: 'home', description: Faker::Lorem.sentence, rulebook_id: create(:rulebook).id }
        }
        expect(response).to redirect_to(group_path(Group.last))
        expect(Group.first.name).to eq('test group')
      end
    end

    context 'failure' do
      it 'redirects without creating' do
        post :create, params: { user_id: user.id, group: { name: nil, city: nil, description: nil } }
        expect(response).to be_successful
        expect(Group.count).to eq(0)
      end
    end
  end

  describe '#show' do
    it 'renders a show page' do
      get :show, params: { id: group.id }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@group)).to eq(group)
    end
  end

  describe '#edit' do
    it 'renders an edit page' do
      get :edit, params: { id: group.id }
      expect(response).to be_successful
      expect(controller.instance_variable_get(:@group)).to eq(group)
    end
  end

  describe '#update' do
    context 'success' do
      it 'updates the group and redirects' do
        patch :update, params: { id: group.id, group: { city: 'Test' } }
        expect(response).to redirect_to(group_path(group))
        expect(Group.first.city).to eq('Test')
      end
    end

    context 'failure' do
      it 'redirects without updating' do
        patch :update, params: { id: group.id, group: { name: nil } }
        expect(response).to be_successful
        expect(Group.first).to eq(group)
      end
    end
  end

  describe '#destroy' do
    it 'destroys group and redirects' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(user_path(user))
      expect(Group.find_by(id: group.id)).to eq(nil)
    end
  end
end
