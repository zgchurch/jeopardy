class AddWinnerToGames < ActiveRecord::Migration
  def change
    add_column :games, :winner_id, :integer
    add_index :games, :winner_id
  end
end
