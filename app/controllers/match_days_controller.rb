class MatchDaysController < ApplicationController
    before_action :authorize_admin, only: [:new, :create]
    before_action :get_round

    def show
        @match_day = MatchDay.includes(:matches).find(params[:id])
    end

    def new
        @match_day = MatchDay.new
    end

    def create
        @match_day = MatchDay.new(match_day_params) 
        @match_day.round_id = params[:round_id]
        if @match_day.save
            redirect_to round_match_days_path(round_id: params[:round_id]), notice: "Utworzono nowy dzień meczowy"
        else
            redirect_to new_round_match_day_path(round_id: params[:round_id]), alert: @match_day.errors.full_messages.first
        end
    end

    private

    def match_day_params
        params.require(:match_day).permit(:stop_bet_time, :day_number, :round_id)
    end

    def get_round
        @round = Round.find(params[:round_id])
    end
end
