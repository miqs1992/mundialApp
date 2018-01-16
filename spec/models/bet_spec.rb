require 'rails_helper'

RSpec.describe Bet, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:bet)).to be_valid  
  end

  it "is valid with user, match and scores" do
    user = FactoryBot.build(:user)
    match = FactoryBot.build(:match)
    bet = Bet.new(
      user: user,
      match: match,
      score1: 0,
      score2: 2
    )
    expect(bet).to be_valid  
  end

  it { should belong_to(:user) }
  it { should belong_to(:match) }  
  it { should validate_numericality_of(:score1).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:score2).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:score1) }
  it { should validate_presence_of(:score2) }
  it { should validate_presence_of(:points) }

  it "gives 3 points for exact bid" do
    user = FactoryBot.build(:user)
    match = FactoryBot.build(:match)
    match.score1 = 3
    match.score2 = 0
    bet = Bet.new(
      user: user,
      match: match,
      score1: 3,
      score2: 0
    )
    bet.calculate
    expect(bet.points).to eql(3)
  end

  it "gives 1 point for proper winner bid" do
    user = FactoryBot.build(:user)
    match = FactoryBot.build(:match)
    match.score1 = 3
    match.score2 = 0
    bet = Bet.new(
      user: user,
      match: match,
      score1: 1,
      score2: 0
    )
    bet.calculate
    expect(bet.points).to eql(1)
  end

  it "gives 0 points for wrong bid" do
    user = FactoryBot.build(:user)
    match = FactoryBot.build(:match)
    match.score1 = 3
    match.score2 = 0
    bet = Bet.new(
      user: user,
      match: match,
      score1: 2,
      score2: 5
    )
    bet.calculate
    expect(bet.points).to eql(0)
  end

  it "returns 1 if player bet team1 wins" do
    bet = FactoryBot.build(:bet)
    bet.score1 = 3
    bet.score2 = 0
    expect(bet.winner).to eql(1)
  end

  it "returns 2 if player bet team2 wins" do
    bet = FactoryBot.build(:bet)
    bet.score1 = 0
    bet.score2 = 3
    expect(bet.winner).to eql(2)
  end

  it "returns 2 if player bet draw" do
    bet = FactoryBot.build(:bet)
    bet.score1 = 1
    bet.score2 = 1
    expect(bet.winner).to eql(0)
  end
end
