class LeaguesController < ApplicationController
  before_action :authorize_admin, only: [:new, :create, :destory]
  def index
    @leagues = League.includes(:user_leagues).all
  end

  def show
    @league = League.includes(:users).find(params[:id])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params) 
    if @league.save
        redirect_to leagues_path, notice: "Utworzono nową ligę"
    else
        redirect_to new_league_path, alert: @league.errors.full_messages.first
    end
  end

  def destroy
    League.find(params[:id]).destroy
  end

  private 

  def league_params
    params.require(:league).permit(:name)
  end
  
end
