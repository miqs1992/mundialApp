require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserLeaguesHelper. For example:
#
# describe UserLeaguesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
