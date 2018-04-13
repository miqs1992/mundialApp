require 'rails_helper'

RSpec.configure do |config| 
    config.render_views = true 
end 

RSpec.describe UsersController, type: :controller do
    before do
        user = FactoryBot.create(:user, :admin)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
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

    describe "#new" do
        it "responds successfully" do
            get :new
            expect(response).to be_success
        end
    
        it "returns a 200 response" do
            get :new
            expect(response).to have_http_status "200"
        end
    end

    describe "#create" do
        context "with valid attributes" do
            it "saves the new user in the database" do
                expect{post :create, params: {user: FactoryBot.attributes_for(:user)}}.to change{User.count}.by(1)
            end
            it "redirects to the users page" do
                post :create, params: {user: FactoryBot.attributes_for(:user)}
                expect(response).to redirect_to users_path
            end
        end

        context "with invalid attributes" do
            it "does not save the new user in the database" do
                expect{post :create, params: {user:  {login: ""}}}.to change{User.count}.by(0)
            end
            it "redirects to the new user page" do
                post :create, params: {user: {login: ""}}
                expect(response).to redirect_to new_user_path
            end
        end
    end
end
