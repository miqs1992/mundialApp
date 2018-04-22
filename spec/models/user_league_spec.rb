require 'rails_helper'

RSpec.describe UserLeague, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:league) }
  
  it 'validates uniqueness of user scoped to league' do
    FactoryBot.create(:user_league)
    should validate_uniqueness_of(:user_id).scoped_to(:league_id)
  end

  it 'has valid factory' do
    expect(FactoryBot.build(:user_league)).to be_valid
  end
end
