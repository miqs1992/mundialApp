class AddMainToLeague < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :main, :boolean, default: false, null: false, index: true
  end
end
