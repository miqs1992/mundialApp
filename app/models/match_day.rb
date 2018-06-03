class MatchDay < ApplicationRecord
  validates_presence_of :stop_bet_time
  validates_presence_of :day_number
  validates_uniqueness_of :day_number

  has_many :matches
  belongs_to :round

  def calculate
    self.matches.each do |m|
      m.calculate
    end
    User.recalculate
    User.send_match_day_email(self)
  end

  def is_bet?(user)
    Bet.where(match_id: self.matches.pluck(:id), user_id: user.id).any?
  end
end
