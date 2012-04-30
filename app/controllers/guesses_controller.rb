class GuessesController < ApplicationController
  before_filter :find_game

  def create
    make_guess
    switch_players

    if @game.winner
      flash.notice = "You won! You're pretty much a pro."
    elsif @game.complete?
      flash.notice = "You lost! --with #{@game.guesses.wrong.count} wrong guesses"
    end

    redirect_to @game
  end


  def switch_players
    other_player = (@game.users - [current_user]).first
    if other_player
      @game.update_attribute(:current_player, other_player)
    end
  end

  def make_guess
    if @game.final_round? || params[:guess][:letter].length > 1
      @game.guess_word(current_user, params[:guess][:letter])
    else
      @game.guess(current_user, params[:guess][:letter])
    end
  end
    
  def find_game
    @game = current_user.games.find(params[:game_id])
  end

end
