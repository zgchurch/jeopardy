class AddHitToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :hit, :boolean

  end
end
