class BetsController < ApplicationController
  def index
    @bets = current_user.bets.includes(:match).order('matches.start_time')
  end

  def update_many
    @bets = Bet.where(id: params[:bets].keys, user_id: current_user.id)
    @bets.update_all(bonus: false)
    @bets.each do |bet|
      unless bet.update(bet_params(params[:bets][bet.id.to_s]))
        @alert = bet.errors.first[1]
      end
    end
    if params[:bonus] && !params[:bonus][:bet_id].empty?
      bonus_bet = @bets.find(params[:bonus][:bet_id].to_i)
      if bonus_bet.is_bonus_used?
        @alert = "Bonus został zużyty"
      else
        bonus_bet.update(bonus: true)
      end
    end
    @bets.reload
  end

  private

  def bet_params(my_params)
    my_params.permit(:score1, :score2)
  end
end