class GamesController < ApplicationController
  def create
    redirect_to current_user.single_player_games.create(:current_player => current_user)
  end

  def show
    @game = Game.find(params[:id])
    @guess = Guess.new
  end
end
