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

  def calculate
    match = self.match
    case
      when !match.finished
        self.update_attribute(:points, 0)
      when match.score1 == self.score1 && match.score2 == self.score2
        self.update_attribute(:points, 3)
      when self.winner == match.winner
        self.update_attribute(:points, 1)
      else
        self.update_attribute(:points, 0)
    end
  end

  def winner
    if(self.score1 == self.score2)
      return 0
    elsif(self.score1 > self.score2)
      return 1
    else
      return 2
    end
  end

  def print
    "#{self.score1} - #{self.score2}"
  end

  private

    def stop_bet_time_is_ok
      return if self.match.nil? #crashed other tests
      errors.add(:base, "It is too late for changing") if self.match.match_day.stop_bet_time < Time.current
    end 

end
