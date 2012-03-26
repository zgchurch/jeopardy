class GuessesController < ApplicationController
  def create
    @game = current_user.games.find(params[:game_id])
    @game.guess(current_user, params[:guess][:letter])
    if @game.complete?
      if @game.guesses.wrong.count < 7
        flash.notice = "You won! You're pretty much a pro."
      elsif @game.guesses.wrong.count < 12 
        flash.notice = "You won! You're decent."
      elsif @game.guesses.wrong.count < 16 
        flash.notice = "You won! You kinda suck, with #{@game.guesses.wrong.count} wrong guesses, but you made it."
      else
        flash.notice = "You finished the game! Not sure if I'd call it winning since you took #{@game.guesses.wrong.count} wrong guesses; you basically pound on the keyboard like a gorilla."
      end
    end
    redirect_to @game
  end
end
