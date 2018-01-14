class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :city, null: false, default: ""
      t.datetime :start_time, null: false
      t.integer :team1_id
      t.integer :team2_id
      t.integer :score1
      t.integer :score2
      t.timestamps
    end
    add_index :matches, :team1_id
    add_index :matches, :team2_id
    add_index :matches, :city
  end
end
