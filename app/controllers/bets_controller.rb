class BetsController < ApplicationController
    def index
        @bets = current_user.bets.order(:id, :desc)
    end
end
