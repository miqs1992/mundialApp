require 'rails_helper'

RSpec.describe Round, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:round)).to be_valid  
  end

  it "is valid with title, factor" do
    round = Round.new(
      title: "Runda pierwsza",
      score_factor: 1
    )
    expect(round).to be_valid  
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:score_factor) }
  it { should have_many(:match_days) } 
  it { should validate_uniqueness_of(:title) }

  it "return bets" do
    user = FactoryBot.create(:user)
    round = FactoryBot.create(:round)
    md1 = FactoryBot.create(:match_day, round: round)
    md2 = FactoryBot.create(:match_day, round: round)
    m1 = FactoryBot.create(:match, match_day: md1)
    m2 = FactoryBot.create(:match, match_day: md2)
    FactoryBot.create(:bet, match: m1, user: user)
    FactoryBot.create(:bet, match: m2, user: user)
    round2 = FactoryBot.create(:round)
    md3 = FactoryBot.create(:match_day, round: round2)
    m3 = FactoryBot.create(:match, match_day: md3)
    FactoryBot.create(:bet, match: m3, user: user)
    expect(round.bets.count).to eq 2
  end

  it 'returns true if bonus is used by user' do
    user = FactoryBot.create(:user)
    round = FactoryBot.create(:round)
    md1 = FactoryBot.create(:match_day, round: round)
    m1 = FactoryBot.create(:match, match_day: md1)
    m2 = FactoryBot.create(:match, match_day: md1)
    FactoryBot.create(:bet, match: m1, user: user)
    expect(round.is_bonus_used?(user.id)).to be_falsey
    FactoryBot.create(:bet, match: m2, user: user, bonus: true)
    expect(round.is_bonus_used?(user.id)).to be_truthy
  end
end