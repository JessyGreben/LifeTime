class ChangeDatatypeOfLifeExpectancy < ActiveRecord::Migration
  def up
	change_column :days, :life_expectancy, :integer
  end

  def down
  	change_column :days, :life_expectancy, :decimal
  end
end
