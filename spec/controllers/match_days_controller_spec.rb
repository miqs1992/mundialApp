require 'rails_helper'

RSpec.describe MatchDaysController, type: :controller do
    before(:each) do
        @user = FactoryBot.create(:user)
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        @round = FactoryBot.create(:round)
        @match_day = FactoryBot.create(:match_day, :round => @round)
    end
end
