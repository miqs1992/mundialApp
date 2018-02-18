require 'rails_helper'

RSpec.describe MatchesHelper, type: :helper do
    
    describe "print bet" do
        before(:each) do
            @match_day = FactoryBot.create(:match_day, :stop_bet_time => (Time.current + 1.hour))
            @match = FactoryBot.create(:match, :match_day => @match_day)
            @user = FactoryBot.create(:user)
        end

        it "returns link to new bet if no bet" do
            expect(helper.print_bet(@user.id, @match, @match_day)).to eq(link_to("obstaw", new_user_bet_path(@user.id)))
        end

        it "returns edit link if there is bet and match is not finished" do
            bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
            expect(helper.print_bet(@user.id, @match, @match_day)).to eq(link_to("0 - 2", edit_user_bet_path(@user.id, bet.id)))
        end

        it "returns points if match is finished" do
            bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
            @match.set_score(0,2)
            @match.calculate
            expect(helper.print_bet(@user.id, @match.reload, @match_day)).to eq(link_to("3 pkt", user_bet_path(@user.id, bet.id)))
        end

        it "returns show link if stop bet time passed" do
            bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
            @match_day.update(:stop_bet_time => (Time.current - 1.hour))
            @match_day.save
            expect(helper.print_bet(@user.id, @match.reload, @match_day.reload)).to eq(link_to("0 - 2", user_bet_path(@user.id, bet.id)))
        end
    end 
end