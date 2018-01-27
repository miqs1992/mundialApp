require 'rails_helper'

RSpec.describe MatchDay, type: :model do
  it "has valid factory" do
    expect(FactoryBot.build(:match_day)).to be_valid  
  end

  it "is valid with stop_bet_time, round and number" do
    round = FactoryBot.build(:round)
    day = MatchDay.new(
      stop_bet_time: Time.current,
      round: round,
      day_number: 1
    )
    expect(day).to be_valid  
  end

  it { should validate_presence_of(:stop_bet_time) }
  it { should validate_presence_of(:day_number) }
  it { should have_many(:matches) } 
  it { should belong_to(:round) } 
  it { should validate_uniqueness_of(:day_number) }

  it "calculates all bets belonging to match day" do
    match_day = FactoryBot.create(:match_day)
    match1 = FactoryBot.create(:match, :match_day => match_day)
    match2 = FactoryBot.create(:match, :match_day => match_day)
    bet1 = FactoryBot.create(:bet, :match => match1, :score1 => 0, :score2 => 2 )
    bet2 = FactoryBot.create(:bet, :match => match1, :score1 => 0, :score2 => 3 )
    bet3 = FactoryBot.create(:bet, :match => match2, :score1 => 2, :score2 => 1 )
    match1.set_score(0,2)
    match2.set_score(2,1)
    match_day.calculate
    expect(bet1.reload.points).to eq(3)  
    expect(bet2.reload.points).to eq(1)
    expect(bet3.reload.points).to eq(3)
  end
end
