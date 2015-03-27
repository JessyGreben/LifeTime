class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :steps

      t.timestamps
    end
  end
end
