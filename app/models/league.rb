class League < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_leagues, dependent: :destroy
  has_many :users, -> { order(:points => :desc) }, through: :user_leagues

  def place(user)
    users.where('points > ?', user.points).count + 1
  end
end
