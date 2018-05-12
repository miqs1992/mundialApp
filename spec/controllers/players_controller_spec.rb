require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  before(:each) do
    @admin = FactoryBot.create(:user, :admin)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@admin)
    5.times do 
      FactoryBot.create(:player)
    end
  end


  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :index
      expect(response).to have_http_status '200'
    end
  end

end
