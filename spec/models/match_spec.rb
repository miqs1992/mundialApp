require 'rails_helper'

RSpec.describe Match, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:match)).to be_valid  
  end

  it "is valid with city, 2 teams and time" do
    team1 = FactoryBot.build(:team)
    team2 = FactoryBot.build(:team)
    day = FactoryBot.build(:match_day)
    match = Match.new(
      start_time: Time.current,
      team1: team1,
      team2: team2,
      city: "Moscow",
      match_day: day
    )
    expect(match).to be_valid  
  end

  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:city) }
  it { should validate_numericality_of(:score1).allow_nil }
  it { should validate_numericality_of(:score2).allow_nil }
  it { should have_many(:bets) } 
  it { should belong_to(:match_day) }
  it { should belong_to(:team1).class_name('Team') }
  it { should belong_to(:team2).class_name('Team') }

  it "returns 1 if team1 won" do
    match = FactoryBot.build(:match)
    match.set_score(3,0)
    expect(match.winner).to eql(1)
  end

  it "returns 2 if team2 won" do
    match = FactoryBot.build(:match)
    match.set_score(0,3)
    expect(match.winner).to eql(2)
  end

  it "returns 0 if it was a draw" do
    match = FactoryBot.build(:match)
    match.set_score(1,1)
    expect(match.winner).to eql(0)
  end

  it "returns nil if match is not finished" do
    match = FactoryBot.build(:match, score1: 1, score2: 1)
    expect(match.winner).to eql(nil)
  end

  it "sets proper score and changes finished to true" do
    match = FactoryBot.build(:match)
    expect(match.finished).to eq(false)
    match.set_score(2,1)
    expect(match.score1).to eq(2)
    expect(match.score2).to eq(1)
    expect(match.finished).to eq(true)    
  end
end
