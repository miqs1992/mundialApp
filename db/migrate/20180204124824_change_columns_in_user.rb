class ChangeColumnsInUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :approved, :admin
  end
end
