class Bet < ApplicationRecord
  validates_numericality_of :score1, greater_than_or_equal_to: 0
  validates_numericality_of :score2, greater_than_or_equal_to: 0
  validates_numericality_of :points, greater_than_or_equal_to: 0
  validates_presence_of :score1
  validates_presence_of :score2
  validates_presence_of :points

  belongs_to :user
  belongs_to :match

  def calculate
    match = self.match

    if(match.score1 == self.score1 && match.score2 == self.score2)
      self.points = 3
      return
    end

    if(self.winner == match.winner)
      self.points = 1
      return
    end

    # for recalculations
    self.points = 0
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

end
