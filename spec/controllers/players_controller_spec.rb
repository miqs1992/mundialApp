require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  before(:each) do
    @admin = FactoryBot.create(:user, :admin)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@admin)
    5.times do 
      FactoryBot.create(:player)
    end
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

  describe '#edit' do
    it 'responds successfully' do
      get :edit, params: { id: Player.first.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :edit, params: { id: Player.first.id }
      expect(response).to have_http_status '200'
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'updates match in the database' do
        expect do
          patch :update, params: {
            id: Player.first.id,
            player: { goals: 5 }
          }
        end .to change { Player.first.goals }.to(5)
      end
      it 'redirects to the index page' do
        patch :update, params: {
          id: Player.first.id,
          player: { goals: 5 }
        }
        expect(response).to redirect_to players_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not update' do
        expect do
          patch :update, params: {
            id: Player.first.id,
            player: { goals: -2 }
          }
        end .to not_change { Player.first.goals }
      end

      it 'redirects to edit' do
        patch :update, params: {
          id: Player.first.id,
            player: { goals: -2 }
        }
        expect(response).to redirect_to edit_player_path
        expect(flash[:alert]).to be_present
      end
      
    end
  end
end
