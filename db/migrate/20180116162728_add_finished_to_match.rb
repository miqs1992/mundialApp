class AddFinishedToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :finished, :boolean, default: false, null: false, index: true
  end
end
