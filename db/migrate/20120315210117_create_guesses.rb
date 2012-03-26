class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.references :user
      t.references :game
      t.string :letter

      t.timestamps
    end
    add_index :guesses, :user_id
    add_index :guesses, :game_id
  end
end
