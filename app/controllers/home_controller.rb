class HomeController < ApplicationController
  def index
    @league = League.where(main: true).first
    @last_match_day = MatchDay.where('stop_bet_time < ?', Time.current).order(stop_bet_time: :desc).first
    @next_match_day = MatchDay.where('stop_bet_time >= ?', Time.current).order(stop_bet_time: :asc).first
  end
end
