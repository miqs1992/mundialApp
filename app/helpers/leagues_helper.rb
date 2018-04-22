module LeaguesHelper
  def render_leave(user_league)
    link_to 'Wystąp', user_league_path(
      id: user_league.id,
      league_id: user_league.league_id
    ), remote: true, method: :delete, class: 'btn btn-warning btn-sm'
  end

  def render_join(league_id)
    link_to 'Dołącz', user_leagues_path(user_league: { 
      league_id: league_id
    }), remote: true, method: :post, class: 'btn btn-primary btn-sm'
  end
end
