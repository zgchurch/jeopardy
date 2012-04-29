class Game < ActiveRecord::Base
  belongs_to :word
  has_many :plays
  has_many :users, :through => :plays
  has_many :guesses 
  belongs_to :current_player, :class_name => 'User'
  belongs_to :winner, :class_name => 'User'

  validates_presence_of :word
  before_validation :choose_word, :on => :create
  before_validation :generate_masked_word, :on => :create

  def choose_word
    self.word = Word.random
  end

  def to_s
    if users.count > 1
      "Multi-player game between #{users.to_sentence} started #{created_at.to_date}"
    else
      "Single-player game started #{created_at.to_date}"
    end
  end

  def generate_masked_word
    positions = []
    positions = (positions + [rand(word.text.length)]).uniq until positions.length == 6
    masked_word = word.text.gsub(/./, '*')
    positions.each {|n| masked_word[n] = word.text[n] }
    self.masked_word = masked_word
  end

  def guess(user, letter)
    new_masked_word = read_attribute(:masked_word)
    hit = false
    word.text.chars.each_with_index do |c, i|
      if c.downcase == letter[0].downcase && new_masked_word[i] == '*'
        new_masked_word[i] = letter[0]
        hit = true
      end
    end

    if hit
      play_for(user).update_attribute(:score, play_for(user).score + 1)
    else
      play_for(user).update_attribute(:score, play_for(user).score - 1)
    end

    reload
    update_attribute :masked_word, new_masked_word
    guesses.create! :user => user, :letter => letter, :hit => hit
    check_complete user
  end
  
  def guess_word(user, w)
    hit = false
    if w == word.text
      update_attribute :masked_word, w
      hit = true
      play_for(user).update_attribute(:score, play_for(user).score + 5)
    end
    guesses.create! :user => user, :letter => w, :hit => hit
    check_complete
  end

  def check_complete(user)
    if complete? && masked_word == word.text
      update_attribute :winner, user
      plays.each do |play|
        if play.user == user
          play.update_attribute(:score, play.score + 10)
        else
          play.update_attribute(:score, play.score - 5)
        end
      end
    end
  end
  
  def play_for(user)
    plays.where(:user_id => user.id).first
  end
  
  def complete?
    users.map{|u| guesses.by(u).count > 3 }.all? || masked_word == word.text
  end
end
