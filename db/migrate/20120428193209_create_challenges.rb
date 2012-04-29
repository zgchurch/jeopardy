class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :challenger
      t.references :challengee
      t.string :message

      t.timestamps
    end
    add_index :challenges, :challenger_id
    add_index :challenges, :challengee_id
  end
end
