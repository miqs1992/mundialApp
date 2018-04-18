require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'has valid factory' do
    expect(FactoryBot.build(:team)).to be_valid
  end

  it 'is valid with name, flag' do
    team = Team.new(
      name: 'France',
      flag: 'fr'
    )
    expect(team).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:flag) }
  it { should have_many(:players) } 
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:flag) }
  it { should have_many(:selected_by).class_name('User').with_foreign_key('team_id') }

  it 'prints team with flag' do
    team = FactoryBot.create(:team)
    expected = "<span class=\"flag-icon flag-icon-#{team.flag}\"></span> #{team.name}"
    expect(team.print).to eq(expected)
  end
end
