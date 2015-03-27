class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.integer :jid
      t.integer :age
      t.string :gender
      t.integer :weight_kgs
      t.integer :height_meters
      t.string :image

      t.timestamps
    end
  end
end
