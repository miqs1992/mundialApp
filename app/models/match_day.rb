class MatchDay < ApplicationRecord
  validates_presence_of :stop_bet_time
  validates_presence_of :day_number
  validates_uniqueness_of :day_number

  has_many :matches
  belongs_to :round
end
