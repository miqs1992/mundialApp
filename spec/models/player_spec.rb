require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'has valid factory' do
    expect(FactoryBot.build(:player)).to be_valid
  end

  it 'is valid with first name, last name, team' do
    team = FactoryBot.build(:team)
    player = Player.new(
      first_name: 'Jan',
      last_name: 'Kowalski',
      team: team
    )
    expect(player).to be_valid
  end

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should belong_to(:team) }
  it { should have_many(:selected_by).class_name('User').with_foreign_key('player_id') }
end
