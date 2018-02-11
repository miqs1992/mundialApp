require 'rails_helper'

RSpec.describe User, type: :model do

  it "has valid factory" do
    expect(FactoryBot.build(:user)).to be_valid  
  end

  it "is valid with first name, last name, login, email, password" do
    user = User.new(
      first_name: "Jan",
      last_name: "Kowalski",
      login: "jkowal",
      email: "j.kowalski@gmail.com",
      password: "password123"
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

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "Jan", last_name: "Kowalski")
    expect(user.name).to eq "Jan Kowalski"
  end

  it "sums user bids points" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:bet, :points => 3, :user => user)
    FactoryBot.create(:bet, :points => 1, :user => user)
    FactoryBot.create(:bet, :points => 0, :user => user)
    user1 = FactoryBot.create(:user)
    FactoryBot.create(:bet, :points => 3, :user => user1)
    expect(user.points).to eq 4 
    expect(user1.points).to eq 3
  end 

  it "sends welcome mail" do
    user = FactoryBot.create(:user)
    ActiveJob::Base.queue_adapter = :test
    expect {
      user.send_new_account_message
    }.to have_enqueued_job.on_queue('mailers')
  end
end
