class GamesController < ApplicationController
  def create
    redirect_to current_user.games.create(:current_player => current_user)
  end

  def show
    @game = Game.find(params[:id])
    @guess = Guess.new
  end
end
