class CreateMatchDays < ActiveRecord::Migration[5.1]
  def change
    create_table :match_days do |t|
      t.datetime :stop_bet_time
      t.integer :day_number
      t.references :round, index: true
      t.timestamps
    end

    add_reference(:matches, :match_day, index: true)
  end
end
