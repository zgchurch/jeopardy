class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :single_player_game, :foreign_key => :game_id
  belongs_to :multi_player_game, :foreign_key => :game_id
end
