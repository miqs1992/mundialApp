require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  before(:each) do
    @admin = FactoryBot.create(:user, :admin)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@admin)
    @match_day = FactoryBot.create(:match_day)
    @match = FactoryBot.create(:match, match_day: @match_day)
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

  describe '#new' do
    it 'responds successfully' do
      get :new
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :new
      expect(response).to have_http_status '200'
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves the new match in the database' do
        expect do
          post :create, params: {
            match: FactoryBot.attributes_for(:match).merge(
              match_day_id: @match_day.id,
              team2_id: Team.first.id,
              team1_id: Team.last.id
            )
          }
        end .to change { Match.count }.by(1)
      end
      it 'redirects to the match page' do
        post :create, params: {
          match: FactoryBot.attributes_for(:match).merge(
            match_day_id: @match_day.id,
            team2_id: Team.first.id,
            team1_id: Team.last.id
          )
        }
        expect(response).to redirect_to matches_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new match in the database' do
        expect do
          post :create, params: {
            match: { start_time: nil }
          }
        end .to change { Match.count }.by(0)
      end
      it 'redirects to the new match page' do
        post :create, params: {
          match: { start_time: nil }
        }
        expect(response).to redirect_to new_match_path
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe '#edit' do
    it 'responds successfully' do
      get :edit, params: { id: @match.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :edit, params: { id: @match.id }
      expect(response).to have_http_status '200'
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      before(:each) do
        @time = DateTime.new(2001, 2, 3, 4, 5, 6)
      end
      it 'updates match in the database' do
        expect do
          patch :update, params: {
            id: @match.id,
            match: { start_time: @time }
          }
        end .to change { @match.reload.start_time }.to(@time)
      end
      it 'redirects to the match page' do
        patch :update, params: {
          id: @match.id,
          match: { start_time: @time }
        }
        expect(response).to redirect_to matches_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not update match' do
        expect do
          patch :update, params: {
            id: @match.id,
            match: { start_time: nil }
          }
        end .to not_change { @match.reload.start_time }
      end
      it 'redirects to edit' do
        patch :update, params: {
          id: @match.id,
          match: { start_time: nil }
        }
        expect(response).to redirect_to edit_match_path
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe '#edit_score' do
    it 'responds successfully' do
      get :edit_score, params: { id: @match.id }
      expect(response).to be_success
    end

    it 'returns a 200 response' do
      get :edit_score, params: { id: @match.id }
      expect(response).to have_http_status '200'
    end
  end

  describe '#set_score' do
    context 'with valid attributes' do
      it 'sets score and changes finished flag' do
        expect do
          patch :set_score, params: {
            id: @match.id, match: { score1: 1, score2: 3 }
          }
        end .to change { @match.reload.score1 }.to(1).and change { @match.score2 }.to(3).and change { @match.finished }.to(true)
      end
      it 'redirects to the match page' do
        patch :set_score, params: { id: @match.id, match: { score1: 1, score2: 3 } }
        expect(response).to redirect_to matches_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not set score if score is nil' do
        expect do
          patch :set_score, params: {
            id: @match.id, match: { score1: 1, score2: nil }
          }
        end .to not_change { @match.reload.score1 }
      end

      it 'does not set score if score is less than zero' do
        expect do
          patch :set_score, params: {
            id: @match.id, match: { score1: 1, score2: -3 }
          }
        end .to not_change { @match.reload.score1 }.and not_change { @match.score2 }.and not_change { @match.finished }
      end

      it 'redirects to edit score page if score is nil' do
        patch :set_score, params: {
          id: @match.id, match: { score1: 1, score2: nil }
        }
        expect(response).to redirect_to edit_score_match_path(id: @match.id)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
