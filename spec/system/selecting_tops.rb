require 'rails_helper'

RSpec.describe 'Betting', type: :system do
  before(:each) do
    @user = FactoryBot.create(:user, :no_tops)
    @match_day = FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
    3.times do
      team = FactoryBot.create(:team)
      3.times do
        FactoryBot.create(:player, team: team)
      end
    end
    login_as(@user)
  end

  it 'redirects to edit page if no tops' do
    expect(@user.top_team).to eq(nil)
    expect(@user.top_player).to eq(nil)
    visit root_path
    expect(current_path).to eq(edit_user_path(@user))
  end

  it "doesn't redirect if after first match day" do
    FactoryBot.create(:match_day, stop_bet_time: Time.current - 1.day)
    visit root_path
    expect(current_path).not_to eq(edit_user_path(@user))
  end

  it "doesn't redirect if user picked tops" do
    @user.update(team_id: Team.first.id, player_id: Player.first.id)
    @user.save!
    visit root_path
    expect(current_path).to eq(root_path)
  end
end
