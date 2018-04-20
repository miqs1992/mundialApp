class League < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :users, through: :user_leagues
  has_many :user_leagues, dependent: :destroy
end
