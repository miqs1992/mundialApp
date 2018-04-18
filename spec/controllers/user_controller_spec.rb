require 'rails_helper'

RSpec.configure do |config|
  config.render_views = true
end

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user, :admin)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
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

  describe '#new' do
    it 'responds successfully' do
      get :new
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :new
      expect(response).to have_http_status '200'
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect { post :create, params: { user: FactoryBot.attributes_for(:user) } }.to change { User.count }.by(1)
      end
      it 'redirects to the users page' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to users_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect do
          post :create, params: {
            user: { login: '' }
          }
        end.to change { User.count }.by(0)
      end
      it 'redirects to the new user page' do
        post :create, params: { user: { login: '' } }
        expect(response).to redirect_to new_user_path
      end
    end
  end

  describe '#edit' do
    it 'responds successfully' do
      get :edit, params: { id: @user.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :edit, params: { id: @user.id }
      expect(response).to have_http_status '200'
    end

    it 'returns a 302 response if visit different user' do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user.id }
      expect(response).to have_http_status '302'
    end
  end

  describe '#update' do
    before(:each) do
      @team = FactoryBot.create(:team)
      @player = FactoryBot.create(:player)
      FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
    end

    context 'with valid attributes' do
      it 'updates user team and player' do
        expect do
          post :update, params: {
            id: @user.id,
            user: { team_id: @team.id, player_id: @player.id }
          }
        end.to change {
          @user.reload.top_team
        }.to(@team).and change {
          @user.top_player
        }.to(@player)
      end
      it 'redirects to root path' do
        post :update, params: {
          id: @user.id,
          user: { team_id: @team.id, player_id: @player.id }
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes -> when it is too late' do
      before(:each) do
        FactoryBot.create(:match_day, stop_bet_time: Time.current - 1.day)
      end

      it 'does not update user team' do
        expect do
          post :update, params: {
            id: @user.id,
            user: { team_id: @team.id, player_id: @player.id }
          }
        end.to(not_change { @user.reload.top_team })
      end

      it 'does not update user player' do
        expect do
          post :update, params: {
            id: @user.id,
            user: { team_id: @team.id, player_id: @player.id }
          }
        end.to(not_change { @user.reload.top_player })
      end

      it 'redirects edit page' do
        post :update, params: {
          id: @user.id,
          user: { team_id: @team.id, player_id: @player.id }
        }
        expect(response).to redirect_to edit_user_path(@user)
      end
    end
  end
end
