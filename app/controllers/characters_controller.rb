class CharactersController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @characters = @user.characters
  end

  def show
  end

end