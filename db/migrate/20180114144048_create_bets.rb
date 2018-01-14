class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.references :user, index: true
      t.references :match, index: true
      t.integer :score1, null: false, default: 0
      t.integer :score2, null: false, default: 0
      t.integer :points, null: false, default: 0
      t.timestamps
    end
  end
end
