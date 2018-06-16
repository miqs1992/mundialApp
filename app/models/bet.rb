class Bet < ApplicationRecord
  validates_numericality_of :score1, greater_than_or_equal_to: 0
  validates_numericality_of :score2, greater_than_or_equal_to: 0
  validates_numericality_of :points, greater_than_or_equal_to: 0
  validates_presence_of :score1
  validates_presence_of :score2
  validates_presence_of :points
  validates_uniqueness_of :user_id, scope: :match_id
  validate :stop_bet_time_is_ok

  belongs_to :user
  belongs_to :match

  delegate :match_day, to: :match
  delegate :round, to: :match

  def calculate
    value = 0
    case
      when !match.finished
        return
      when match.score1 == self.score1 && match.score2 == self.score2 
        value = 3
      when self.winner == match.winner
        value = 1
    end
    if self.bonus
      value *= 2
    end
    self.update_attribute(:points, value)
  end

  def winner
    if(self.score1 == self.score2)
      0
    elsif(self.score1 > self.score2)
      1
    else
      2
    end
  end

  def print
    "#{self.score1} - #{self.score2}#{" *" if self.bonus}"
  end

  def is_bonus_used?
    self.round.is_bonus_used?(self.user_id, self.id)
  end

  def get_css
    case self.points
    when 1..2
      "draw"
    when 3..6
      "win"
    else
      ""
    end
  end

  private

    def stop_bet_time_is_ok
      return if self.match.nil? #crashed other tests
      errors.add(:base, "It is too late for changing") if self.match.match_day.stop_bet_time < Time.current
    end 
end
