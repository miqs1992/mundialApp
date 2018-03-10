module MatchesHelper
    def print_bet(user_id, match, stop_bet_time)
        bet = match.bets.where(:user_id => user_id).first
        if bet.nil?
            return link_to("obstaw", new_user_bet_path(user_id))
        end
        if match.finished
            return link_to("#{bet.points} pkt", user_bet_path(user_id, bet.id))
        end
        txt = "#{bet.score1} - #{bet.score2}"
        if(stop_bet_time > Time.current)
            return link_to(txt, edit_user_bet_path(user_id, bet.id))
        end
        return link_to(txt, user_bet_path(user_id, bet.id))

    end
end
