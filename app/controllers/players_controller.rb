class PlayersController < ApplicationController

  def index
    if params[:gamertag] && params[:gamertag] != ""
      @player = Destiny.search_for_player(params[:platform], params[:gamertag])
      respond_to do |format|
        format.html
        format.json { render json: { player: @player} }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {player: nil}, status: 400 }
      end
    end
  end

end
