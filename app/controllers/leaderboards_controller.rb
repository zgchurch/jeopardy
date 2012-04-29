class LeaderboardsController < ApplicationController
  def show
    @users = User.with_total_scores.order('total_score DESC')
  end
end
