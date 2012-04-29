class AddCurrentPlayerToGame < ActiveRecord::Migration
  def change
    add_column :games, :current_player_id, :integer
    add_index :games, :current_player_id
  end
end
