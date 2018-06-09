class MatchDaysController < ApplicationController
  before_action :authorize_admin, only: :finish
  before_action :before_stop_bet_time, only: :picks
  before_action :after_stop_bet_time, only: :show

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

  def picks
    @matches = Match.where(match_day_id: params[:id]).order(:id).load
    @bets = Bet.includes(:user).where(match_id: @matches.pluck(:id)).group_by(&:user_id)
  end

  private  
  
  def before_stop_bet_time
    redirect_to root_path, alert: 'Nie podglądamy!' if Time.current < MatchDay.find(params[:id]).stop_bet_time
  end

  def after_stop_bet_time
    redirect_to picks_match_day_path(id: params[:id]) unless Time.current < MatchDay.find(params[:id]).stop_bet_time
  end
end
