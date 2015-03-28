class RemoveLifeDataFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :life_expectancy, :decimal
  	remove_column :users, :life_gained_lost, :integer
  end
end
