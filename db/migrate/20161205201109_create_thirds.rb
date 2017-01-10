class CreateThirds < ActiveRecord::Migration[5.0]
  def change
    create_table :thirds do |t|
      t.string :title

      t.timestamps
    end
  end
end
