class AddLifeDataToDays < ActiveRecord::Migration
  def change
    add_column :days, :life_expectancy, :decimal
    add_column :days, :life_gained_lost, :integer
    add_column :days, :total_lgl, :integer
  end
end
