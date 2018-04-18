module ApplicationHelper
  def before_first_game?
    start_time = MatchDay.minimum(:stop_bet_time)
    start_time.nil? || start_time > Time.current
  end
end
