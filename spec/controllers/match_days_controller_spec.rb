require 'rails_helper'

RSpec.describe MatchDaysController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
    @match_day = FactoryBot.create(:match_day)
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

  describe '#show' do
    it 'responds successfully' do
      get :show, params: { id: @match_day.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :show, params: { id: @match_day.id }
      expect(response).to have_http_status '200'
    end
  end
end
