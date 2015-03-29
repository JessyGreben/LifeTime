class AddLifeDataToDays < ActiveRecord::Migration
  def change
    add_column :days, :life_expectancy, :decimal #in years
    add_column :days, :life_gained_lost, :integer #in seconds
    add_column :days, :total_lgl, :integer #in seconds
  end
end
