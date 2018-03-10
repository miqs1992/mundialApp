require 'rails_helper'

RSpec.describe 'Creating resources', :type => :system do
    before(:each) do
        @admin = FactoryBot.create(:user, :admin)
        login_as(@admin)
    end

    it "can create round" do
        visit rounds_path
        click_on 'Nowa runda'
        fill_in 'round[title]', :with => 'newtitle'
        fill_in 'round[score_factor]', :with => 2
        expect { click_on 'Utwórz rundę' }.to change{Round.count}.by(1)
    end

    it "can create match day" do
        round = FactoryBot.create(:round)
        visit round_path(id: round.id)
        click_on 'Nowy dzień'
        fill_in 'match_day[day_number]', :with => 5
        fill_in 'match_day[stop_bet_time]', :with => Time.current
        expect { click_on 'Utwórz dzień' }.to change{MatchDay.count}.by(1)
    end


end