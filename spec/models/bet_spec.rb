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
end
