class UpdatePlaysScore < ActiveRecord::Migration
  def up
    change_column :plays, :score, :integer, :default => 0, :null => false
  end

  def down
  end
end
