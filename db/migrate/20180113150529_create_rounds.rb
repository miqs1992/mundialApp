class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.string :title, null: false, default: ""
      t.integer :score_factor, null: false, default: 1
      t.timestamps
    end
  end
end
