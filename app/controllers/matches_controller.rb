class MatchesController < ApplicationController
    before_action :authorize_admin, only: [:new, :create]

    def index
        @match = Match.where(:match_day => params[:match_day])
    end

    def show
        @match = Match.find(params[:id])
    end

    def new
        @match = Match.new
    end

    def create
        match_day = MatchDay.find(params[:match_day_id])
        @match = match_day.matches.new(match_params) 
        if @match.save
            redirect_to round_match_day_matches_path(
                round_id: params[:round_id], match_day_id: params[:match_day_id]
            ), notice: "Utworzono nowy mecz"
        else
            redirect_to new_round_match_day_match_path(
                round_id: params[:round_id], match_day_id: params[:match_day_id]
            ), alert: @match.errors.full_messages.first
        end
    end

    private

    def match_params
        params.require(:match).permit(:city, :start_time, :team1_id, :team2_id)
    end
    
end
