class AddMeaningsToWords < ActiveRecord::Migration
  def change
    add_column :words, :meaning, :text

  end
end
