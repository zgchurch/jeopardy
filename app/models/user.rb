class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :plays
  has_many :games, :through => :plays
  has_many :single_player_games, :through => :plays
  has_many :multi_player_games, :through => :plays
  has_many :guesses
  has_many :challenges, :foreign_key => 'challengee_id'
  has_many :sent_challenges, :class_name => 'Challenge', :foreign_key => 'challenger_id'

  validates :username, :presence => true, :uniqueness => true
  validates :birthdate, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true

  scope :online, where(:status => 'online')
  scope :with_total_scores, joins(:plays).group(:id).select('users.*, sum(score) as total_score')
  scope :active, where(:deleted_at => nil)

  def to_s
    username
  end

  def total_score
    plays.select('sum(score) as score').first.score
  end

  def username_with_score
    "#{username} (#{total_score} pts)"
  end

  def online?
    status == 'online'
  end

  def destroy
    update_attribute :deleted_at, Time.now
    challenges.destroy_all
    sent_challenges.destroy_all
  end

  def active?
    deleted_at.nil?
  end
  
  def wins
	plays.joins("inner join plays p2 on plays.game_id = p2.game_id and plays.id != p2.id").where("p2.score < plays.score")

  end
  def losses
	plays.joins("inner join plays p2 on plays.game_id = p2.game_id and plays.id != p2.id").where("p2.score > plays.score")

  end
  def draws 
	plays.joins("inner join plays p2 on plays.game_id = p2.game_id and plays.id != p2.id").where("p2.score = plays.score")
  end
  def top_three_letters 
	guesses.group("letter").order("count(letter) desc").limit(3).to_sentence
  end
	
end
