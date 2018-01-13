class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.integer :goals, default: 0, null: false
      t.integer :assists, default: 0, null: false
      t.timestamps
    end

    add_index :players, :goals
  end
end
