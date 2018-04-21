class UserLeaguesController < ApplicationController
  def create
    @ul = current_user.user_leagues.new(user_league_params)
    if @ul.save
      @notice = "Dodano do ligi o id: #{@ul.league_id}"
    else
      @alert = @ul.errors.full_messages.first
    end
  end
  
  def destroy
    @league_id = params[:league_id]
    UserLeague.find(params[:id]).destroy
  end

  private 

  def user_league_params
    params.require(:user_league).permit(:league_id)
  end
end
