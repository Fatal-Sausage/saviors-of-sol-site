class PlayersController < ApplicationController

  def index
    if query = params[:gamertag]
      page = params[:page] || 1
      @players = Player.search_players(query, page)
    end
  end

  def show
    @player = Player.show_player(params[:id])
  end

end