require 'rails_helper'

RSpec.describe UserLeaguesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
    @league = FactoryBot.create(:league)
  end

  describe '#create' do
    it 'creates new user league with valid attributes' do
      expect  do
        post :create, params: {
          user_league: { league_id: @league.id }
        }, xhr: true
      end .to change { @user.leagues.count }.by(1)
    end
    
    it "doesn't create new user league with invalid attributes" do
      expect  do
        post :create, params: {
          user_league: { league_id:nil }
        }, xhr: true
      end .to not_change { @user.leagues.count }
    end

    it "doesn't create new user league when already same ona exists" do
      UserLeague.create(user_id: @user.id, league_id: @league.id)
      expect  do
        post :create, params: {
          user_league: { league_id:@league.id }
        }, xhr: true
      end .to not_change { @user.leagues.count }
    end
  end

  describe '#destroy' do
    it 'destroys user league' do
      ul = UserLeague.create(user_id: @user.id, league_id: @league.id)
      expect  do
        delete :destroy, params: {
          id: ul.id
        }, xhr: true
      end .to change { @user.leagues.count }.by(-1)
    end
  end
end
