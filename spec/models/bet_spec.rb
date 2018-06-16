require 'rails_helper'

RSpec.describe Bet, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:bet)).to be_valid  
  end

  it "is valid with user, match and scores" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    bet = Bet.new(
      user: user,
      match: match,
      score1: 0,
      score2: 2
    )
    expect(bet).to be_valid  
  end

  it "is invalid if the same pair of user and match" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    FactoryBot.create(:bet, match: match, user: user)
    bet = Bet.new(
      user: user,
      match: match,
      score1: 0,
      score2: 2
    )
    expect(bet).not_to be_valid 
  end

  it { should belong_to(:user) }
  it { should belong_to(:match) }  
  it { should validate_numericality_of(:score1).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:score2).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:score1) }
  it { should validate_presence_of(:score2) }
  it { should validate_presence_of(:points) }
  it { should delegate_method(:round).to(:match) }
  it { should delegate_method(:match_day).to(:match) }

  it "is invalid if Time.current is bigger than match day's stop bet time" do
    match_day = FactoryBot.create(:match_day, stop_bet_time: Time.current - 1.hour)
    match = FactoryBot.create(:match, match_day: match_day)
    bet = FactoryBot.build(:bet, match: match)
    expect(bet).not_to be_valid 
  end

  it "does not update if Time.current is bigger than match day's stop bet time" do
    match_day = FactoryBot.create(:match_day, stop_bet_time: Time.current + 1.day)
    match = FactoryBot.create(:match, match_day: match_day)
    bet = FactoryBot.create(:bet, match: match)
    match_day.update(stop_bet_time: Time.current - 1.hour)
    expect{bet.update(score1: 2)}.to not_change{bet.reload.score1}
  end

  it "gives 3 points for exact bid" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    bet = Bet.create(user: user, match: match, score1: 3, score2: 0)
    match.set_score(3,0)
    bet.calculate
    expect(bet.points).to eql(3)
  end

  it "gives 1 point for proper winner bid" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    bet = Bet.create(user: user, match: match, score1: 1, score2: 0)
    match.set_score(3,0)
    bet.calculate
    expect(bet.points).to eql(1)
  end

  it "gives 0 points for wrong bid" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    bet = Bet.create(user: user, match: match, score1: 0, score2: 2)
    match.set_score(3,0)
    bet.calculate
    expect(bet.points).to eql(0)
  end

  it "multiplies points if bonud used" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    match = FactoryBot.create(:match)
    bet1 = Bet.create(user: user1, match: match, score1: 3, score2: 0, bonus: true)
    bet2 = Bet.create(user: user2, match: match, score1: 1, score2: 0, bonus: true)
    match.set_score(3,0)
    match.calculate
    expect(bet1.reload.points).to eql(6)
    expect(bet2.reload.points).to eql(2)
  end

  it "gives 0 points for match is not finished" do
    user = FactoryBot.create(:user)
    match = FactoryBot.create(:match, score1: 3, score2: 0)
    bet = Bet.create(user: user, match: match, score1: 3, score2: 0)
    bet.calculate
    expect(bet.points).to eql(0)
  end

  it "returns 1 if player bet team1 wins" do
    bet = FactoryBot.build(:bet, score1: 3, score2: 0)
    expect(bet.winner).to eql(1)
  end

  it "returns 2 if player bet team2 wins" do
    bet = FactoryBot.build(:bet, score1: 0, score2: 3)
    expect(bet.winner).to eql(2)
  end

  it "returns 0 if player bet draw" do
    bet = FactoryBot.build(:bet, score1: 1, score2: 1)
    expect(bet.winner).to eql(0)
  end

  it 'prints bet' do
    bet = FactoryBot.build(:bet, score1: 1, score2: 2)
    expect(bet.print).to eq("1 - 2")
    expect(bet.print).not_to include("*")
  end

  it 'prints * if bonus' do
    bet = FactoryBot.create(:bet, bonus: true)
    expect(bet.print).to include("*")
  end

  it 'checks if bonus already used' do
    user = FactoryBot.create(:user)
    round = FactoryBot.create(:round)
    md1 = FactoryBot.create(:match_day, round: round)
    md2 = FactoryBot.create(:match_day, round: round)
    m1 = FactoryBot.create(:match, match_day: md1)
    m2 = FactoryBot.create(:match, match_day: md2)
    bet1 = FactoryBot.create(:bet, match: m1, user: user)
    bet2 = FactoryBot.create(:bet, match: m2, user: user)
    expect(bet2.is_bonus_used?).to be_falsey
    bet1.update(bonus: true)
    expect(bet2.is_bonus_used?).to be_truthy
  end

  it 'returns proper css' do
    bet = FactoryBot.create(:bet)
    expect(bet.get_css).to eq("")
    bet.update(points: 1)
    expect(bet.get_css).to eq("draw")
    bet.update(points: 3)
    expect(bet.get_css).to eq("win")
  end
end
