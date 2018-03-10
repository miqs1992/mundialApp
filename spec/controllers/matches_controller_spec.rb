require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
    before(:each) do
        @user = FactoryBot.create(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        @round = FactoryBot.create(:round)
        @match_day = FactoryBot.create(:match_day, :round => @round)
        @match = FactoryBot.create(:match, :match_day => @match_day)
    end

    describe "#show" do
        it "responds successfully" do
            get :show, params: { round_id: @round.id, match_day_id: @match_day.id, id: @match.id }
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :show, params: { round_id: @round.id, match_day_id: @match_day.id, id: @match.id }
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as admin" do
        before(:each) do
            @user.update(admin: true)
        end
        
        it "responds successfully" do
            get :new, params: { round_id: @round.id, match_day_id: @match_day.id }
            expect(response).to be_success
        end

        it "returns a 200 response" do
            get :new, params: { round_id: @round.id, match_day_id: @match_day.id }
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as user" do
        it "responds successfully" do
            get :new, params: { round_id: @round.id, match_day_id: @match_day.id }
            expect(response).to redirect_to root_path
        end

        it "returns a 200 response" do
            get :new, params: { round_id: @round.id, match_day_id: @match_day.id }
            expect(response).to have_http_status "302"
        end
    end


    describe "#create" do
        before(:each) do
            @user.update(admin: true)
        end
        context "with valid attributes" do
            it "saves the new match in the database" do
                expect{post :create, params: {
                    round_id: @round.id,
                    match_day_id: @match_day.id,
                    match: FactoryBot.attributes_for(:match).merge({
                        match_day_id: @match_day.id,
                        team2_id: Team.first.id,
                        team1_id: Team.last.id
                    })
                }}.to change{Match.count}.by(1)
            end
            it "redirects to the match page" do
                post :create, params: {
                    round_id: @round.id,
                    match_day_id: @match_day.id,
                    match: FactoryBot.attributes_for(:match).merge({
                        match_day_id: @match_day.id,
                        team2_id: Team.first.id,
                        team1_id: Team.last.id
                    })
                }
                expect(response).to redirect_to round_match_day_matches_path(round_id:  @round.id, match_day_id: @match_day.id )
            end
        end

        context "with invalid attributes" do
            it "does not save the new match day in the database" do
                expect{post :create, params: {
                    round_id: @round.id,
                    match_day_id: @match_day.id,
                    match: {start_time: nil}
                }}.to change{Match.count}.by(0)
            end
            it "redirects to the new match day page" do
                post :create, params: {
                    round_id: @round.id,
                    match_day_id: @match_day.id,
                    match: {start_time: nil}
                }
                expect(response).to redirect_to new_round_match_day_match_path(round_id: @round.id, match_day_id: @match_day.id )
            end
        end
    end
end
