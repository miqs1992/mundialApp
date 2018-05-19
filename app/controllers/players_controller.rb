class PlayersController < ApplicationController
  before_action :authorize_admin, only: [:edit, :update]
  def index
    @players = Player.includes(:team).order(goals: :desc, assists: :desc)
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      redirect_to players_path, notice: "Zaktualizowano zawodnika #{@player.name}"
    else
      redirect_to edit_player_path(@player), alert: @player.errors.full_messages.first
    end
  end

  private

  def player_params
    params.require(:player).permit(:first_name, :last_name, :team_id, :goals, :assists, :number)
  end


end
