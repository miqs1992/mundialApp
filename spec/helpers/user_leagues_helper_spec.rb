require 'rails_helper'

RSpec.describe UserLeaguesHelper, type: :helper do
  before(:each) do
    @user = FactoryBot.create(:user)
    @league = FactoryBot.create(:league)
  end

  describe 'render leave' do
    it 'renders proper link' do
      ul = UserLeague.create(league_id: @league.id, user_id: @user.id)
      expect(
        helper.render_leave(ul)
      ).to include(user_league_path(
                     id: ul.id,
                     league_id: @league.id
      ))
    end
  end

  describe 'render join' do
    it 'renders proper link' do
      expect(
        helper.render_join(@league.id)
      ).to include(user_leagues_path(user_league: { 
        league_id: @league.id
      }))
    end
  end
end
