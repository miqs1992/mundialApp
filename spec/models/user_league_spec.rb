require 'rails_helper'

RSpec.describe UserLeague, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:league) }

  it 'has valid factory' do
    expect(FactoryBot.build(:user_league)).to be_valid
  end
end
