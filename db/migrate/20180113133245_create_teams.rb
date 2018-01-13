class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.string :flag, null: false, default: ""
      t.boolean :winner, null: false, default: false
      t.timestamps
    end

    add_column :players, :team_id, :integer
    add_index :players, :team_id
    add_index :teams, :name
  end
end
