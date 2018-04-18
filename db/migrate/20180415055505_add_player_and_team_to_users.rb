class AddPlayerAndTeamToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :team, foreign_key: true, index: true
    add_reference :users, :player, foreign_key: true, index: true
  end
end
