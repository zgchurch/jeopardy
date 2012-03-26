class Game < ActiveRecord::Base
  belongs_to :word
  #has_and_belongs_to_many :users
  has_many :plays
  has_many :users, :through => :plays
  has_many :guesses 

  validates_presence_of :word
  before_validation :choose_word, :on => :create
  before_validation :generate_masked_word, :on => :create

  def choose_word
    self.word = Word.random
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
      if c.downcase == letter[0].downcase
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
  end
  
  def guess_word(user, w)
    hit = false
    if w == word.text
      update_attribute :masked_word, w
      hit = true
      play_for(user).update_attribute(:score, play_for(user).score + 5)
    end
    guesses.create! :user => user, :letter => w, :hit => hit
  end
  
  def play_for(user)
    plays.where(:user_id => user.id).first
  end
  
  def complete?
    guesses.count >= 4
  end
  
  def winner?
    masked_word == word.text
  end
    
end
