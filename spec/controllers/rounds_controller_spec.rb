require 'rails_helper'

RSpec.describe RoundsController, type: :controller do
    before(:each) do
        @user = FactoryBot.create(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        @round = FactoryBot.create(:round)
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

    describe "#show" do
        it "responds successfully" do
            get :show, params: { id: @round.id }
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :show, params: { id: @round.id }
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as admin" do
        before(:each) do
            @user.update(admin: true)
        end
        
        it "responds successfully" do
            get :new
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :new
            expect(response).to have_http_status "200"
        end
    end

    describe "#new as user" do
        it "responds successfully" do
            get :new
            expect(response).to redirect_to root_path
        end
    
        it "returns a 200 response" do
            get :new
            expect(response).to have_http_status "302"
        end
    end

    describe "#create" do
        before(:each) do
            @user.update(admin: true)
        end
        context "with valid attributes" do
            it "saves the new round in the database" do
                expect{post :create, params: {round: FactoryBot.attributes_for(:round)}}.to change{Round.count}.by(1)
            end
            it "redirects to the round index" do
                post :create, params: {round: FactoryBot.attributes_for(:round)}
                expect(response).to redirect_to rounds_path
            end
        end

        context "with invalid attributes" do
            it "does not save the new round in the database" do
                expect{post :create, params: {round:  {day_number: ""}}}.to change{Round.count}.by(0)
            end
            it "redirects to the new round page" do
                post :create, params: {round: {day_number: ""}}
                expect(response).to redirect_to new_round_path
            end
        end
    end
end
