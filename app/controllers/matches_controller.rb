class MatchesController < ApplicationController
    before_action :authorize_admin

    def index
        @match = Match.all.order(:start_time)
    end

    def show
        @match = Match.find(params[:id])
    end

    def new
        @match = Match.new
    end

    def create
        @match = Match.new(match_params) 
        if @match.save
            redirect_to matches_path, notice: "Utworzono nowy mecz"
        else
            redirect_to new_match_path, alert: @match.errors.full_messages.first
        end
    end

    def edit
        @match = Match.find(params[:id])
    end

    def update
        @match = Match.find(params[:id])
        if @match.update_attributes(match_params)
            redirect_to matches_path, notice: "Zaktualizowano mecz o id #{@match.id}"
        else
            redirect_to edit_match_path(id: @match.id), alert: @match.errors.full_messages.first
        end
    end 

    def edit_score
        @match = Match.find(params[:id])
    end

    def set_score
        @match = Match.find(params[:id])
        score1 = params[:match][:score1].to_i
        score2 = params[:match][:score2].to_i
        if score_params && score1 >= 0 && score2 >= 0
            @match.set_score(params[:match][:score1], params[:match][:score2])
            redirect_to matches_path, notice: "Ustawiono wynik meczu o id #{@match.id}"
        else
            redirect_to edit_score_match_path(id: @match.id), alert: "Wystapił błąd"
        end
    end

    private

    def match_params
        params.require(:match).permit(:city, :start_time, :team1_id, :team2_id, :match_day_id)
    end

    def score_params
        begin
            params.require(:match).require([:score1, :score2])
            true
        rescue
            false
        end  
    end
    
end
