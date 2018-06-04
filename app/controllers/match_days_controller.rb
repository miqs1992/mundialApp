class MatchDaysController < ApplicationController
  before_action :authorize_admin, only: :finish
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

  def finish
    @match_day = MatchDay.includes(:matches).find(params[:id])
    if @match_day.matches.where(finished: false).any?
      @alert = "Nie wszystkie mecze są zakończone"
    else
      @match_day.calculate
      @notice = "Zakończono dzień meczowy #{@match_day.id}"
    end
  end
end
