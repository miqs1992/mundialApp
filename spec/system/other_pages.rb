require 'rails_helper'

RSpec.describe 'Leagues management', type: :system do
  before(:each) do
    @user = FactoryBot.create(:user)
    @user.leagues << FactoryBot.create(:league, main: true)
  end

  it 'main page' do
    last_md = FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
    next_md = FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
    other_user = FactoryBot.create(:user)
    m1 = FactoryBot.create(:match, match_day: last_md)
    @user.bets.create(match: m1, score1: 2, score2: 1)
    other_user.bets.create(match: m1, score1: 3, score2: 0)
    m2 = FactoryBot.create(:match, match_day: last_md)
    @user.bets.create(match: m2, score1: 2, score2: 2)
    other_user.bets.create(match: m2, score1: 2, score2: 0)
    last_md.update(stop_bet_time: Time.current - 1.day)
    m1.set_score(3,0)
    m2.set_score(0,1)
    last_md.calculate
    m3 = FactoryBot.create(:match, match_day: next_md)
    m4 = FactoryBot.create(:match, match_day: next_md)
    login_as(@user.reload)
    visit root_path
    expect(page.find('#user_points').text).to eq("1")
    expect(page.find('#user_place').text).to eq("2")
    expect(page.find('#is_bet').text).to eq("NIE")
    expect(page.find("#match_#{m1.id} td:nth-child(2)").text).to eq("3 - 0")
    expect(page.find("#match_#{m1.id} td:nth-child(3)").text).to eq("2 - 1")
    expect(page.find("#match_#{m1.id} td:nth-child(4)").text).to eq("1")
    expect(page.find("#match_#{m3.id} td:nth-child(4)").text).to eq("Obstaw")
  end
end
