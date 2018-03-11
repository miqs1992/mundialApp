require 'rails_helper'

RSpec.describe MatchesHelper, type: :helper do
    
    describe "print bet" do
        before(:each) do
            @stop_bet_time = Time.current + 1.hour
            @match = FactoryBot.create(:match)
            @user = FactoryBot.create(:user)
        end

        it "prints score if match is finished" do
            @match.set_score(2,0)
            expect(helper.print_score(@match)).to eq("2 - 0")
        end

        it "prints link if match is not finished" do
            expect(helper.print_score(@match)).to eq(
                link_to "Ustaw", edit_score_match_path(@match.id), :class => "btn btn-primary btn-xs"
            )
        end


        # it "returns link to new bet if no bet" do
        #     expect(helper.print_bet(@user.id, @match, @stop_bet_time)).to eq(link_to("obstaw", new_user_bet_path(@user.id)))
        # end

        # it "returns edit link if there is bet and match is not finished" do
        #     bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
        #     expect(helper.print_bet(@user.id, @match, @stop_bet_time)).to eq(link_to("0 - 2", edit_user_bet_path(@user.id, bet.id)))
        # end

        # it "returns points if match is finished" do
        #     bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
        #     @match.set_score(0,2)
        #     @match.calculate
        #     expect(helper.print_bet(@user.id, @match.reload, @stop_bet_time)).to eq(link_to("3 pkt", user_bet_path(@user.id, bet.id)))
        # end

        # it "returns show link if stop bet time passed" do
        #     bet = FactoryBot.create(:bet, :match => @match, :user => @user, :score1 => 0, :score2 => 2 )
        #     expect(helper.print_bet(@user.id, @match.reload, (Time.current - 1.hour))).to eq(link_to("0 - 2", user_bet_path(@user.id, bet.id)))
        # end
    end 
end