class RemoveBinaryFieldFromFirsts < ActiveRecord::Migration[5.0]
  def change
    remove_column :firsts, :bin, :binary
  end
end
