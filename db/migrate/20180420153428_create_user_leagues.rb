class CreateUserLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :user_leagues do |t|
      t.references :user, index: true
      t.references :league, index: true
      t.timestamps
    end
    add_foreign_key :user_leagues, :users
    add_foreign_key :user_leagues, :leagues
    add_index :user_leagues, [:user_id, :league_id], unique: true
  end
end
