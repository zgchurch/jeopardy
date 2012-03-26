class CreateGamesUsers < ActiveRecord::Migration
  def change
    create_table :games_users do |t|
      t.references :game
      t.references :user
    end
  end
end
