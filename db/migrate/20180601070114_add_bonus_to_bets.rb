class AddBonusToBets < ActiveRecord::Migration[5.1]
  def change
    add_column :bets, :bonus, :boolean, default: false, null: false
  end
end
