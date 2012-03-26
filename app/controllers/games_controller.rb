class GamesController < ApplicationController
  def create
    redirect_to current_user.games.create
  end

  def show
    if params[:id]
      @game = Game.find(params[:id])
    else
      redirect_to current_user.games.last
    end
    @guess = Guess.new
  end
end
