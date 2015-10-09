class PlayersController < ApplicationController

  def index
    if query = params[:gamertag]
      # page = params[:page] || 1
      # @players = Player.search_players(query, page)
      @player = Destiny.search_for_player(params[:platform], params[:gamertag])
    end
  end

  def show
    @player = Player.show_player(params[:id])
  end

  def getplayer
    @player = Destiny.search_for_player(params[:platform], params[:gamertag])
    render json: { player: @player }
  end

end
