require 'rails_helper'

RSpec.describe MatchDaysController, type: :controller do
    before(:each) do
        @user = FactoryBot.create(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        @round = FactoryBot.create(:round)
        @match_day = FactoryBot.create(:match_day, :round => @round)
    end

    describe "#show" do
        it "responds successfully" do
            get :show, params: { round_id: @round.id, id: @match_day.id }
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :show, params: { round_id: @round.id, id: @match_day.id }
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as admin" do
        before(:each) do
            @user.update(admin: true)
        end
        
        it "responds successfully" do
            get :new, params: { round_id: @round.id }
            expect(response).to be_success
        end

        it "returns a 200 response" do
            get :new, params: { round_id: @round.id }
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as user" do
        it "responds successfully" do
            get :new, params: { round_id: @round.id }
            expect(response).to redirect_to root_path
        end

        it "returns a 200 response" do
            get :new, params: { round_id: @round.id }
            expect(response).to have_http_status "302"
        end
    end


    describe "#create" do
        before(:each) do
            @user.update(admin: true)
        end
        context "with valid attributes" do
            it "saves the new match day in the database" do
                expect{post :create, params: {
                    round_id: @round.id,
                    match_day: FactoryBot.attributes_for(:match_day)
                }}.to change{MatchDay.count}.by(1)
            end
            it "redirects to the match day page" do
                post :create, params: {
                    round_id: @round.id,
                    match_day: FactoryBot.attributes_for(:match_day)
                }
                expect(response).to redirect_to round_match_days_path(round_id:  @round.id)
            end
        end

        context "with invalid attributes" do
            it "does not save the new match day in the database" do
                expect{post :create, params: {
                    round_id: @round.id,
                    match_day: {stop_bet_time: nil}
                }}.to change{MatchDay.count}.by(0)
            end
            it "redirects to the new match day page" do
                post :create, params: {
                    round_id: @round.id,
                    match_day: {stop_bet_time: nil}
                }
                expect(response).to redirect_to new_round_match_day_path(round_id:  @round.id)
            end
        end
    end
end
