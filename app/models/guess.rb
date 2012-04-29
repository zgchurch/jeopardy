class Guess < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  
  scope :wrong, where(:hit => false)

  scope :by, lambda {|user| where(:user_id => user.id)}
end
