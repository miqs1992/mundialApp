require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'is valid with first name, last name, login, email, password' do
    user = User.new(
      first_name: 'Jan',
      last_name: 'Kowalski',
      login: 'jkowal',
      email: 'j.kowalski@gmail.com',
      password: 'password123'
    )
    expect(user).to be_valid
  end

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:login).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_length_of(:password).is_at_most(32) }
  it { should have_many(:bets) }
  it { should belong_to(:top_team).class_name('Team').with_foreign_key('team_id').optional }
  it { should have_many(:user_leagues).dependent(:destroy) }
  it { should have_many(:leagues).through(:user_leagues) }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: 'Jan', last_name: 'Kowalski')
    expect(user.name).to eq 'Jan Kowalski'
  end

  it 'recalculates users ponits' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:bet, points: 3, user: user)
    FactoryBot.create(:bet, points: 1, user: user)
    FactoryBot.create(:bet, points: 0, user: user)
    user1 = FactoryBot.create(:user)
    FactoryBot.create(:bet, points: 3, user: user1)
    User.recalculate
    expect(user.reload.points).to eq 4
    expect(user1.reload.points).to eq 3
  end

  it 'sends welcome mail' do
    user = FactoryBot.create(:user)
    ActiveJob::Base.queue_adapter = :test
    expect do
      user.send_new_account_message
    end.to have_enqueued_job.on_queue('mailers')
  end

  it 'check if user has picked team and player' do
    user = FactoryBot.create(:user, :no_tops)
    expect(user.picked_tops?).to eq(false)
    team = FactoryBot.create(:team)
    player = FactoryBot.create(:player)
    user.update(team_id: team.id)
    expect(user.picked_tops?).to eq(false)
    user.update(player_id: player.id)
    expect(user.picked_tops?).to eq(true)
  end

  it 'adds user to main leagues after create' do
    league = FactoryBot.create(:league, main: true)
    user = FactoryBot.create(:user)
    expect(user.leagues).to include(league)
  end

  it 'adds 12 points if proper tops picked' do
    user = FactoryBot.create(:user)
    user.top_team.update(winner: true)
    user.top_player.update(king: true)
    User.recalculate
    expect(user.reload.points).to eq 12
  end
 
  it 'adds 5 points if proper king picked' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:team, winner: true)
    user.top_player.update(king: true)
    User.recalculate
    expect(user.reload.points).to eq 5
  end

  it 'adds 7 points if proper winner picked' do
    user = FactoryBot.create(:user)
    user.top_team.update(winner: true)
    FactoryBot.create(:player, king: true)
    User.recalculate
    expect(user.reload.points).to eq 7
  end

  it 'does not add points if wrong picks' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:team, winner: true)
    FactoryBot.create(:player, king: true)
    User.recalculate
    expect(user.reload.points).to eq 0
  end

  it 'shows exact bets count' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:bet, user: user, points: 0 )
    FactoryBot.create(:bet, user: user, points: 3 )
    FactoryBot.create(:bet, user: user, points: 6 )
    expect(User.exact_bets.first.bets_count).to eq 2
  end
  
end
