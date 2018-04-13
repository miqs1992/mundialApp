require 'rails_helper'

RSpec.configure do |config| 
    config.render_views = true 
end 

RSpec.describe BetsController, type: :controller do
    before do
        @user = FactoryBot.create(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
    end

    describe "#index" do
        it "responds successfully" do
            get :index
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
        end
    end

    describe "#update many" do
        before(:each) do
            @match_day = FactoryBot.create(:match_day)
            @match1 = FactoryBot.create(:match, :match_day => @match_day)
            @match2 = FactoryBot.create(:match, :match_day => @match_day)
            @bet1 = @user.bets.create(:match => @match1, :score1 => 0, :score2 => 0)
            @bet2 = @user.bets.create(:match => @match2, :score1 => 0, :score2 => 0)
         end
        context "with valid attributes" do
            it "updates bets in the database" do
                expect{
                    post :update_many, params: {
                        bets: Hash[@bet1.id, {score1: 2, score2: 0}, @bet2.id, {score1: 1, score2: 0}]
                        
                    }, xhr: true
                }.to change{@bet1.reload.score1}.from(0).to(2).and change{@bet2.reload.score1}.from(0).to(1)
            end
        end

        context "with invalid attributes" do
            it "doesn't update bets in the database when it is too late" do
                @match_day.update(:stop_bet_time => Time.current - 1.hour)
                @match_day.save
                expect{
                    post :update_many, params: {
                        bets: Hash[@bet1.id, {score1: 2, score2: 0}, @bet2.id, {score1: 0, score2: 0}]
                    }, xhr: true
                }.to not_change{@bet1.reload.score1}
            end

            it "doesn't update bets with wrong data" do
                expect{
                    post :update_many, params: {
                        bets: Hash[@bet1.id, {score1: -1, score2: 0}, @bet2.id, {score1: 0, score2: 0}]
                    }, xhr: true
                }.to not_change{@bet1.reload.score1}
            end

            it "doesn't update other users bets" do
                @other_user = FactoryBot.create(:user)
                @bet3 = @other_user.bets.create(:match => @match1, :score1 => 0, :score2 => 0)
                @bet4 = @other_user.bets.create(:match => @match2, :score1 => 0, :score2 => 0)
                expect{
                    post :update_many, params: {
                        bets: Hash[@bet3.id, {score1: 2, score2: 0}]
                    }, xhr: true
                }.to not_change{@bet3.reload.score1}
            end
        end
    end
end
