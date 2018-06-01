class MatchDaysController < ApplicationController
  def show
    @match_day = MatchDay.includes(:round, :matches).find(params[:id])
    @bets = []
    @match_day.matches.each do |match|
      bet = match.bets.where(user_id: current_user.id).first
      if bet.nil?
        bet = Bet.create(user_id: current_user.id, match_id: match.id, score1: 0, score2: 0)
      end
      @bets.push(bet)
    end
    @bonus_bet = @bets.find { |b| b.bonus == true }
  end

  def index
    @match_days = MatchDay.includes(:round, :matches).all
  end
end
