require 'rails_helper'

RSpec.configure do |config| 
    config.render_views = true 
end 

RSpec.describe BetsController, type: :controller do
    before do
        user = FactoryBot.create(:user)
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
end
