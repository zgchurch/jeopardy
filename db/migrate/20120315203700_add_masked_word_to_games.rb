class AddMaskedWordToGames < ActiveRecord::Migration
  def change
    add_column :games, :masked_word, :string

  end
end
