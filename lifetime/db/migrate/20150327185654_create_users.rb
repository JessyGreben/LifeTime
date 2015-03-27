class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.integer :jid
      t.integer :age
      t.decimal :life_expectancy
      t.integer :life_gained_lost
      t.boolean :gender
      t.integer :weight_kgs
      t.decimal :height_meters
      t.string :image

      t.timestamps
    end
  end
end
