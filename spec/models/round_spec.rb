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
end