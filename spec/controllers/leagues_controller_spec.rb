require 'rails_helper'

RSpec.describe LeaguesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
    @league = FactoryBot.create(:league)
  end

  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :index
      expect(response).to have_http_status '200'
    end
  end

  describe '#show' do
    it 'responds successfully' do
      get :show, params: { id: @league.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :show, params: { id: @league.id }
      expect(response).to have_http_status '200'
    end
  end

  describe '#new' do
    before(:each) do
      @user.update(admin: true)
    end

    it 'responds successfully' do
      get :new, params: { id: @league.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :new, params: { id: @league.id }
      expect(response).to have_http_status '200'
    end
  end

  describe '#create' do
    before(:each) do
      @user.update(admin: true)
    end

    context 'with valid attributes' do
      it 'saves the new league in the database' do
        expect  do
          post :create, params: {
            league: { name: 'example' }
          }
        end .to change { League.count }.by(1)
      end
      it 'redirects to index page' do
        post :create, params: {
          league: { name: 'example' }
        }
        expect(response).to redirect_to leagues_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new league in the database' do
        expect do
          post :create, params: {
            league: { name: nil }
          }
        end .to change { League.count }.by(0)
      end
      it 'redirects to the new league day page' do
        post :create, params: {
          league: { name: nil }
        }
        expect(response).to redirect_to new_league_path
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe '#destroy' do
    it 'responds successfully' do
      expect do
        delete :destroy, params: { id: @league.id }, xhr: true
      end.to change(League, :count).by(-1)
    end
  end
end
