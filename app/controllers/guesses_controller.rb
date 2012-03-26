class GuessesController < ApplicationController
  def create
    @game = current_user.games.find(params[:game_id])
    if @game.guesses.count >=3
      @game.guess_word(current_user, params[:guess][:letter])
    else
      @game.guess(current_user, params[:guess][:letter])
    end
    win
  end
    
    
  def win
      if @game.winner?
        flash.notice = "You won! You're pretty much a pro."
      elsif @game.complete?
        flash.notice = "You lost! --with #{@game.guesses.wrong.count} wrong guesses"
      end
    redirect_to @game
  end
  
end
