class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :games
  has_many :guesses

  validates :username, :presence => true, :uniqueness => true
  validates :birthdate, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true
end
