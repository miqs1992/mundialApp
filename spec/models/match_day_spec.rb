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
end