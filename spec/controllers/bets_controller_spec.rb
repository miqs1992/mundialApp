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

  describe '#update many' do
    before(:each) do
      @match_day = FactoryBot.create(:match_day)
      @match1 = FactoryBot.create(:match, match_day: @match_day)
      @match2 = FactoryBot.create(:match, match_day: @match_day)
      @bet1 = @user.bets.create(match: @match1, score1: 0, score2: 0)
      @bet2 = @user.bets.create(match: @match2, score1: 0, score2: 0)
    end
    context 'with valid attributes' do
      it 'updates bets in the database' do
        expect do
          post :update_many, params: {
            bets: Hash[@bet1.id, { score1: 2, score2: 0 }, @bet2.id, { score1: 1, score2: 0 }]

          }, xhr: true
        end.to change { @bet1.reload.score1 }.from(0).to(2).and change { @bet2.reload.score1 }.from(0).to(1)
      end
    end

    context 'with invalid attributes' do
      it "doesn't update bets in the database when it is too late" do
        @match_day.update(stop_bet_time: Time.current - 1.hour)
        @match_day.save
        expect do
          post :update_many, params: {
            bets: Hash[@bet1.id, { score1: 2, score2: 0 }, @bet2.id, { score1: 0, score2: 0 }]
          }, xhr: true
        end.to(not_change { @bet1.reload.score1 })
      end

      it "doesn't update bets with wrong data" do
        expect do
          post :update_many, params: {
            bets: Hash[@bet1.id, { score1: -1, score2: 0 }, @bet2.id, { score1: 0, score2: 0 }]
          }, xhr: true
        end.to(not_change { @bet1.reload.score1 })
      end

      it "doesn't update other users bets" do
        @other_user = FactoryBot.create(:user)
        @bet3 = @other_user.bets.create(match: @match1, score1: 0, score2: 0)
        @bet4 = @other_user.bets.create(match: @match2, score1: 0, score2: 0)
        expect do
          post :update_many, params: {
            bets: Hash[@bet3.id, { score1: 2, score2: 0 }]
          }, xhr: true
        end.to(not_change { @bet3.reload.score1 })
      end
    end

    describe '#update many with bonus' do
      before(:each) do
        @round = FactoryBot.create(:round)
        @match_day1 = FactoryBot.create(:match_day, round: @round)
        @match11 = FactoryBot.create(:match, match_day: @match_day1)
        @bet11 = @user.bets.create(match: @match11, score1: 0, score2: 0)
        @match12 = FactoryBot.create(:match, match_day: @match_day1)
        @bet12 = @user.bets.create(match: @match12, score1: 0, score2: 0)
        @match_day2 = FactoryBot.create(:match_day, round: @round)
        @match2 = FactoryBot.create(:match, match_day: @match_day2)
        @bet2 = @user.bets.create(match: @match2, score1: 0, score2: 0)
      end

      context 'with valid attributes' do
        it 'updates bets in the database' do
          expect do
            post :update_many, params: {
              bets: Hash[@bet11.id, { score1: 2, score2: 0 }, @bet12.id, { score1: 0, score2: 3 }],
              bonus: { bet_id: @bet11.id.to_s }
            }, xhr: true
          end.to change { @bet11.reload.score1 }.from(0).to(2).and change { @bet11.bonus }.from(false).to(true)
          .and change { @bet12.reload.score2 }.from(0).to(3).and not_change { @bet12.bonus }
        end

        it 'allows to change bonus' do
          @bet12.update(bonus: true)
          expect do
            post :update_many, params: {
              bets: Hash[@bet11.id, { score1: 2, score2: 0 }, @bet12.id, { score1: 0, score2: 3 }],
              bonus: { bet_id: @bet11.id.to_s }
            }, xhr: true
          end.to change { @bet11.reload.score1 }.from(0).to(2).and change { @bet11.bonus }.from(false).to(true)
          .and change { @bet12.reload.score2 }.from(0).to(3).and change { @bet12.bonus }.from(true).to(false)
        end
      end

      context 'with valid attributes' do
        it 'does not update bonus if already used' do
          @bet2.update(bonus: true)
          expect do
            post :update_many, params: {
              bets: Hash[@bet11.id, { score1: 2, score2: 0 }, @bet12.id, { score1: 0, score2: 3 }],
              bonus: { bet_id: @bet11.id.to_s }
            }, xhr: true
          end.to not_change { @bet11.bonus }.and not_change { @bet12.bonus }
          .and change { @bet11.reload.score1 }.from(0).to(2).and change { @bet12.reload.score2 }.from(0).to(3)
        end
      end
    end
  end
end
