class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :word

      t.timestamps
    end
    add_index :games, :word_id
  end
end
