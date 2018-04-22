require 'rails_helper'

RSpec.describe League, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:user_leagues).dependent(:destroy) }
  it { should have_many(:users).through(:user_leagues) }

  it 'has valid factory' do
    expect(FactoryBot.build(:league)).to be_valid
  end

  it 'returns proper place' do
    league = FactoryBot.create(:league)
    user = FactoryBot.create(:user, points: 5)
    league.users << user
    for i in 3..8 do
      league.users << FactoryBot.create(:user, points: i)
    end
    expect(league.place(user)).to eq(4)  
  end
end
