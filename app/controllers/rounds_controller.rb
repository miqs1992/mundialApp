class RoundsController < ApplicationController
    before_action :authorize_admin, only: [:new, :create]

    def index
        @rounds = Round.joins("LEFT JOIN match_days ON rounds.id = match_days.round_id").select("rounds.*, count(match_days.id) as match_day_count").group("rounds.id").order(:id)
    end

    def show
        @round = Round.find(params[:id])
        @match_days = MatchDay.joins("LEFT JOIN matches ON match_days.id = matches.match_day_id").select("match_days.*, count(matches.id) as match_count").group("match_days.id").order(:day_number)
    end

    def new 
        @round = Round.new
    end

    def create
        @round = Round.new(round_params) 
        if @round.save
            redirect_to rounds_path, notice: "Utworzono nową rundę"
        else
            redirect_to new_round_path, alert: @round.errors.full_messages.first
        end
    end
    
    private

    def round_params
        params.require(:round).permit(:title, :score_factor)
    end
    
end