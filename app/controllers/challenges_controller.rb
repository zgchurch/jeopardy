class ChallengesController < ApplicationController
  def index
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(params[:challenge].merge(:challenger => current_user))

    if @challenge.save
      redirect_to challenges_path, :notice => "You have challenged #{@challenge.challengee}."
    else
      render :new
    end
  end

  def update
    @challenge = current_user.challenges.find(params[:id])
    if @challenge.challenger.online?
      @game = MultiPlayerGame.new :users => [@challenge.challenger, @challenge.challengee], :current_player => @challenge.challenger

      if @game.save
        @challenge.destroy
        redirect_to @game
      else
        redirect_to challenges_path
      end
    else
      redirect_to challenges_path, :alert => "Your challenger (#{@challenge.challenger}) is not currently available to play. Please try again shortly."
    end
  end
end
