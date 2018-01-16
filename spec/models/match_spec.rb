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
  it { should have_many(:bets) } 
  it { should belong_to(:match_day) }
  it { should belong_to(:team1).class_name('Team') }
  it { should belong_to(:team2).class_name('Team') }

  it "returns 1 if team1 won" do
    match = FactoryBot.build(:match, score1: 3, score2: 0, finished: true)
    expect(match.winner).to eql(1)
  end

  it "returns 2 if team2 won" do
    match = FactoryBot.build(:match, score1: 0, score2: 3, finished: true)
    expect(match.winner).to eql(2)
  end

  it "returns 0 if it was a draw" do
    match = FactoryBot.build(:match, score1: 1, score2: 1, finished: true)
    expect(match.winner).to eql(0)
  end

  it "returns nil if match is not finished" do
    match = FactoryBot.build(:match, score1: 1, score2: 1)
    expect(match.winner).to eql(nil)
  end
end
