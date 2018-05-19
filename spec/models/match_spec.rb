require 'rails_helper'

RSpec.describe Match, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:match)).to be_valid  
  end

  it "is valid with city, 2 teams and time" do
    team1 = FactoryBot.create(:team)
    team2 = FactoryBot.create(:team)
    day = FactoryBot.create(:match_day)
    match = Match.new(
      start_time: Time.current,
      team1: team1,
      team2: team2,
      city: "Moscow",
      match_day: day
    )
    expect(match).to be_valid  
  end

  it "is invalid with same team as tema1 and team2" do
    team1 = FactoryBot.create(:team)
    day = FactoryBot.create(:match_day)
    match = Match.new(
      start_time: Time.current,
      team1: team1,
      team2: team1,
      city: "Moscow",
      match_day: day
    )
    expect(match).to_not be_valid  
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

  it "calculates all bets belonging to match" do
    match1 = FactoryBot.create(:match)
    bet1 = FactoryBot.create(:bet, :match => match1, :score1 => 0, :score2 => 2 )
    bet2 = FactoryBot.create(:bet, :match => match1, :score1 => 0, :score2 => 3 )
    match1.set_score(0,2)
    match1.calculate
    expect(bet1.reload.points).to eq(3)  
    expect(bet2.reload.points).to eq(1)
  end

  it "prints teams" do 
    team1 = FactoryBot.create(:team)
    team2 = FactoryBot.create(:team)
    match = FactoryBot.create(:match, :team1 => team1, :team2 => team2)
    expected = "<span class=\"flag-icon flag-icon-#{team1.flag}\"></span> #{team1.name} - <span class=\"flag-icon flag-icon-#{team2.flag}\"></span> #{team2.name}"
    expect(match.print_teams).to eq(expected)
  end

  it 'prints points' do
    match = FactoryBot.create(:match)
    expect(match.print_score).to eq("nie zakończony")
    match.set_score(3,0)
    expect(match.print_score).to eq("3 - 0")
  end
end
