class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.references :user
      t.references :game
      t.integer :score

      t.timestamps
    end
    add_index :plays, :user_id
    add_index :plays, :game_id
  end
end
