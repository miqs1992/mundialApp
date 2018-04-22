class CreateLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.string  :name, null: false, default: "", unique: true
      t.timestamps
    end
  end
end
