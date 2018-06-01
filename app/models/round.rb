class Round < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :score_factor
  validates_uniqueness_of :title

  has_many :match_days

  def bets
    Bet.joins(:match => :match_day).where(match_days: { round_id: self.id })
  end

  def is_bonus_used?(user_id)
    self.bets.where(user_id: user_id, bonus: true).any?
  end
  
end
