require 'rails_helper'

RSpec.describe League, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:user_leagues).dependent(:destroy) }
  it { should have_many(:users).through(:user_leagues) }

  it 'has valid factory' do
    expect(FactoryBot.build(:league)).to be_valid
  end

  it 'return proper place if same points but different direct bets' do
    league = FactoryBot.create(:league, main: true)
    md = FactoryBot.create(:match_day)
    m1 = FactoryBot.create(:match, match_day: md)
    m2 = FactoryBot.create(:match, match_day: md)
    m3 = FactoryBot.create(:match, match_day: md)
    u1 = FactoryBot.create(:user)
    u2 = FactoryBot.create(:user)
    u3 = FactoryBot.create(:user)
    u1.bets.create(score1: 1, score2: 2, match: m1)
    u1.bets.create(score1: 2, score2: 1, match: m2)
    u1.bets.create(score1: 2, score2: 1, match: m3)
    u2.bets.create(score1: 0, score2: 2, match: m1)
    u2.bets.create(score1: 1, score2: 1, match: m2)
    u2.bets.create(score1: 1, score2: 1, match: m3)
    u3.bets.create(score1: 0, score2: 0, match: m1)
    u3.bets.create(score1: 1, score2: 0, match: m2)
    u3.bets.create(score1: 1, score2: 1, match: m3)
    m1.set_score(0,2)
    m2.set_score(1,0)
    m3.set_score(1,0)
    md.calculate
    expect(league.place(u1.reload)).to eq(3)
    expect(league.place(u2.reload)).to eq(1)
    expect(league.place(u3.reload)).to eq(1)
  end

  it 'returns orderd users with place' do
    league = FactoryBot.create(:league, main: true)
    md = FactoryBot.create(:match_day)
    m1 = FactoryBot.create(:match, match_day: md)
    m2 = FactoryBot.create(:match, match_day: md)
    m3 = FactoryBot.create(:match, match_day: md)
    u1 = FactoryBot.create(:user)
    u2 = FactoryBot.create(:user)
    u3 = FactoryBot.create(:user)
    u1.bets.create(score1: 1, score2: 2, match: m1)
    u1.bets.create(score1: 2, score2: 1, match: m2)
    u1.bets.create(score1: 2, score2: 1, match: m3)
    u2.bets.create(score1: 0, score2: 2, match: m1)
    u2.bets.create(score1: 1, score2: 1, match: m2)
    u2.bets.create(score1: 1, score2: 1, match: m3)
    u3.bets.create(score1: 0, score2: 0, match: m1)
    u3.bets.create(score1: 1, score2: 0, match: m2)
    u3.bets.create(score1: 1, score2: 1, match: m3)
    m1.set_score(0,2)
    m2.set_score(1,0)
    m3.set_score(1,0)
    md.calculate
    ordered_users = league.get_ordered_users
    expect(ordered_users.length).to eq(3)
    expect(ordered_users.first["place"]).to eq(1)
    expect(ordered_users.last["place"]).to eq(3)
  end
end
