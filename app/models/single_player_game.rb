class SinglePlayerGame < Game
  def update_score_after_guess(user, hit)
    value = bonus_round? ? 2 : 1
    if hit
      play_for(user).update_attribute(:score, play_for(user).score + value)
    else
      play_for(user).update_attribute(:score, play_for(user).score - value)
    end
  end

  def update_score_end_of_game(winner)
    plays.each do |play|
      if play.user == winner
        value = bonus_round? ? 8 : 5
        play.update_attribute(:score, play.score + value)
      end
    end
  end
  
  def complete?
    users.map{|u| guesses.by(u).count > 3 }.all? || masked_word == word.text
  end

  def final_round?
    users.map{|u| guesses.by(u).count > 2 }.all?
  end

  def bonus_round?
    user = users.first
    user.single_player_games.where('games.created_at < ?', created_at).limit(3).order('created_at DESC').map(&:winner_id).uniq == [user.id]
  end
end
