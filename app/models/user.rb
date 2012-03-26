class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :plays
  has_many :games, :through => :plays
  has_many :guesses

  validates :username, :presence => true, :uniqueness => true
  validates :birthdate, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true
end
