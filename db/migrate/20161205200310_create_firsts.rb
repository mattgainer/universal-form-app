class CreateFirsts < ActiveRecord::Migration[5.0]
  def change
    create_table :firsts do |t|
      t.string :name
      t.binary :bin
      t.boolean :active
      t.date :due_date
      t.decimal :cash
      t.float :longitude
      t.integer :second_id
      t.integer :third_value
      t.text :description
      t.time :alarm
      t.timestamps
    end
  end
end
