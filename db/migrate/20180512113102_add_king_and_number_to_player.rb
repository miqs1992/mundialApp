class AddKingAndNumberToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :king, :boolean, default: false, null: false
    add_column :players, :number, :integer, default: 0, null: false
  end
end
