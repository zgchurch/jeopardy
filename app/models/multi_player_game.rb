class MultiPlayerGame < Game
  def update_score_after_guess(user, hit)
    if hit
      play_for(user).update_attribute(:score, play_for(user).score + 1)
    else
      play_for(user).update_attribute(:score, play_for(user).score - 1)
    end
  end

  def update_score_end_of_game(winner)
    plays.each do |play|
      if play.user == winner
        play.update_attribute(:score, play.score + 10)
      else
        play.update_attribute(:score, play.score - 5)
      end
    end
  end

  def complete?
    users.map{|u| guesses.by(u).count > 9 }.all? || masked_word == word.text
  end

  def final_round?
    users.map{|u| guesses.by(u).count > 8 }.all?
  end

  def bonus_round?
    false
  end
end
