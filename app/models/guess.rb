class Guess < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  
  scope :wrong, where(:hit => false)
end
