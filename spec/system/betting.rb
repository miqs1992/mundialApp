require 'rails_helper'

RSpec.describe 'Betting', :type => :system do
    before(:each) do
        @user = FactoryBot.create(:user)
        @match_day = FactoryBot.create(:match_day)
        @match1 = FactoryBot.create(:match, :match_day => @match_day)
        @match2 = FactoryBot.create(:match, :match_day => @match_day)
        login_as(@user)
    end

    it 'creates bets for each match when visiting show match day page' do
        expect(Bet.count).to eq(0)  
        visit match_day_path(@match_day)
        expect(Bet.count).to eq(2)  
    end

    it 'allows user to change bets', :js => true do
        @match_day.update(:stop_bet_time => Time.current + 1.hour)
        @match_day.save
        visit match_day_path(@match_day)
        expect(page).to have_css("input[type=\"submit\"]") 
        fill_in "bets[#{@user.bets.first.id}][score1]", with: "3"
        click_on "Zapisz"
        sleep 1
        expect(@user.bets.first.score1).to eq(3)
        expect(page).to have_css("div.alert-success")
    end

    it 'renders alert when posting wrong params', :js => true do
        @match_day.update(:stop_bet_time => Time.current + 1.hour)
        @match_day.save
        visit match_day_path(@match_day)
        fill_in "bets[#{@user.bets.first.id}][score1]", with: ""
        click_on "Zapisz"
        sleep 1
        expect(page).to have_css("div.alert-danger")
    end

    it 'renders alert when posting after stop bet time', :js => true do
        @match_day.update(:stop_bet_time => Time.current + 1.hour)
        @match_day.save
        visit match_day_path(@match_day)
        @match_day.update(:stop_bet_time => Time.current - 1.hour)
        @match_day.save
        fill_in "bets[#{@user.bets.first.id}][score1]", with: "3"
        click_on "Zapisz"
        sleep 1
        expect(page).to have_css("div.alert-danger")
        expect(@user.bets.first.score1).not_to eq(3)
    end

    it "doesn't render form when it is after stop bet time", :js => true do
        @match_day.update(:stop_bet_time => Time.current - 1.hour)
        @match_day.save
        visit match_day_path(@match_day)
        expect(page).not_to have_css("input[type=\"submit\"]") 
    end

end