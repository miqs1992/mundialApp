class Match < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :start_time
  validates_numericality_of :score1, :allow_nil => true
  validates_numericality_of :score2, :allow_nil => true
  validate :team1_and_team2_are_different

  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  belongs_to :match_day

  has_many :bets
  delegate :round, to: :match_day

  default_scope { includes(:team1, :team2) }

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

  def calculate
    self.bets.each do |b|
      b.calculate
    end
  end 

  def print_teams
    [self.team1, self.team2].collect {|t| "<span class=\"flag-icon flag-icon-#{t.flag} hidden-xs\"></span> #{t.name}" }.join(" - ")
  end

  def print_score
    if self.finished
      "#{self.score1} - #{self.score2}"
    else
      "?"
    end
  end

  private

    def team1_and_team2_are_different
      errors.add(:team1, "must be different than Team2") if team1_id == team2_id
    end 

end
