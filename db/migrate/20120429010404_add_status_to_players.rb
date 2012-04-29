class AddStatusToPlayers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, :default => 'offline', :null => false
    add_index :users, :status
  end
end
