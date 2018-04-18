require 'rails_helper'

RSpec.describe 'Administration', type: :system do
  before(:each) do
    FactoryBot.create(:round)
    @match_day = FactoryBot.create(:match_day)
    4.times do
      FactoryBot.create(:team)
    end
    @admin = FactoryBot.create(:user, :admin)
    login_as(@admin)
  end

  it 'can visit matches path' do
    visit root_path
    click_on 'Mecze'
    expect(page.current_path).to eq matches_path
  end

  it 'can create match' do
    visit matches_path
    click_on 'Utwórz mecz'
    expect(page.current_path).to eq new_match_path
    select(@match_day.day_number, from: 'match[match_day_id]')
    select(find('#match_team1_id > option:nth-child(1)').text, from: 'match[team1_id]')
    select(find('#match_team2_id > option:nth-child(2)').text, from: 'match[team2_id]')
    fill_in 'match[city]',	with: 'Gdynia'
    fill_in 'match[start_time]', with: '01.06.2018, 18:00'
    expect { click_on 'Utwórz' }.to change { Match.count }.by(1)
  end

  it 'can edit match' do
    @team = FactoryBot.create(:team)
    @match = FactoryBot.create(:match)
    expect(@match.team1).not_to eq(@team)
    visit matches_path
    within(:css, "tr#match_#{@match.id}") do
      click_on 'Edit'
    end
    expect(page.current_path).to eq edit_match_path(id: @match.id)
    select(@team.name, from: 'match[team1_id]')
    expect { click_on 'Zaktualizuj' }.to change { @match.reload.team1 }.to(@team)
  end

  it 'can set score' do
    @match = FactoryBot.create(:match, start_time: Time.current - 5.hours)
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    bet1 = FactoryBot.create(:bet, user: user1, match: @match, score1: 0, score2: 1)
    bet2 = FactoryBot.create(:bet, user: user2, match: @match, score1: 0, score2: 3)
    visit matches_path
    within(:css, "tr#match_#{@match.id}") do
      click_on 'Ustaw'
    end
    expect(page.current_path).to eq edit_score_match_path(id: @match.id)
    fill_in 'match[score1]', with: 0
    fill_in 'match[score2]', with: 3
    expect { click_on 'Ustaw wynik' }.to change {
      @match.reload.finished
    }.to(true).and change {
      @match.score1
    }.to(0).and change {
      @match.score2
    }.to(3)
    expect(bet1.reload.points).to eq(1)
    expect(bet2.reload.points).to eq(3)
  end
end
