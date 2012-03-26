class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      t.string :username
      t.date :birthdate
      t.string :city
      t.string :state
      t.string :country
      t.string :name
      t.string :phone

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :username,             :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

end
