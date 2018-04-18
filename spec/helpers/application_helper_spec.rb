require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'print bet' do
    it 'returns true if no match days' do
      expect(helper.before_first_game?).to eq(true)
    end

    it 'returns true if before first match day' do
      FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
      expect(helper.before_first_game?).to eq(true)
    end

    it 'returns false if after first match day' do
      FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
      FactoryBot.create(:match_day, stop_bet_time: Time.current - 1.day)
      expect(helper.before_first_game?).to eq(false)
    end
  end
end
