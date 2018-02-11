class RoundsController < ApplicationController
    before_action :authorize_admin, only: [:new, :create]

    def index
        @rounds = Round.all
    end

    def show
        @round = Round.includes(:match_days).find(params[:id])
    end

    def new 
        @round = Round.new
    end

    def create
        @round = Round.new(round_params) 
        if @round.save
            flash[:notice] = "Utworzono nową rundę"
            redirect_to rounds_path
        else
            flash[:alert] = @round.errors.full_messages.first
            redirect_to new_round_path
        end
    end
    

    private

    def round_params
        params.require(:round).permit(:title, :score_factor)
    end
    
end