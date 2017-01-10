class ChangeFirstCashColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :firsts, :cash, :decimal, precision: 5, scale: 3
  end
end
