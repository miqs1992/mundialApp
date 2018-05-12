class PlayersController < ApplicationController
  def index
    @players = Player.includes(:team).order(goals: :desc, assists: :desc)
  end


end
