class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :image, :img
  end
end
