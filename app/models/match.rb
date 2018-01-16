class Match < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :start_time
  validates_numericality_of :score1, :allow_nil => true
  validates_numericality_of :score2, :allow_nil => true

  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  belongs_to :match_day

  has_many :bets

  def winner
    case
      when !self.finished
        return nil
      when self.score1 == self.score2
        return 0
      when self.score1 > self.score2
        return 1
      else
        return 2
    end
  end

  def set_score(score1, score2)
    self.update_attributes(:score1 => score1, :score2 => score2, :finished => true)
  end

end
