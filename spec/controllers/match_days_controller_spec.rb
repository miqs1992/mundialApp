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

  describe '#finish' do
    before(:each) do
      @match1 = FactoryBot.create(:match, match_day: @match_day)
      @match2 = FactoryBot.create(:match, match_day: @match_day)
      @bet1 = @user.bets.create(match: @match1, score1: 3, score2: 0)
      @bet2 = @user.bets.create(match: @match2, score1: 2, score2: 0)
    end

    context 'when matches finished' do
      before(:each) do
        @match1.set_score(3,0)
        @match2.set_score(2,0)
      end

      it 'updates users score' do
        expect do
          post :finish, params: {
            id: @match_day.id
          }, xhr: true
        end.to change { @user.reload.points }.by(6)
      end

      it 'sends email do users' do
        ActiveJob::Base.queue_adapter = :test
        expect do
          post :finish, params: {
            id: @match_day.id
          }, xhr: true
        end.to have_enqueued_job.on_queue('mailers')
      end
    end

    context 'when matches not finished' do
      it 'does not update users score' do
        expect do
          post :finish, params: {
            id: @match_day.id
          }, xhr: true
        end.to not_change { @user.reload.points }
      end
    end
  end
end
