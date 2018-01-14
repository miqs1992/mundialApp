class Round < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :score_factor
  validates_uniqueness_of :title

  has_many :match_days
end
