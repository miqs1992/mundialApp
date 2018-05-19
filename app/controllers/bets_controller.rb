class BetsController < ApplicationController
  def index
    @bets = current_user.bets.includes(:match).order('matches.start_time')
  end

  def update_many
    @alert = nil
    @bets = []
    params[:bets].keys.each do |id|
      bet = Bet.find(id)
      next unless bet.user_id == current_user.id
      unless bet.update_attributes(bet_params(params[:bets][id]))
        @alert = bet.errors.first
      end
      @bets << bet
    end
  end

  private

  def bet_params(my_params)
    my_params.permit(:score1, :score2)
  end
    
end
