require 'rails_helper'

RSpec.describe 'Leagues management', type: :system do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user)
  end

  it 'allows admin to create league' do
    @user.update(admin: true)
    visit new_league_path
    fill_in "league[name]",	with: "Liga testowa" 
    expect { click_on "Utwórz" }.to change(League, :count).by(1)
    expect(current_path).to eq(leagues_path)
    expect(League.first.main).to eq(false)
  end

  it 'allows admin to create main league' do
    @user.update(admin: true)
    visit new_league_path
    fill_in "league[name]",	with: "Liga testowa" 
    check "league[main]"
    expect { click_on "Utwórz" }.to change(League, :count).by(1)
    expect(League.first.main).to eq(true)
  end
end