class ChangeColumnDefaultInDaysTable < ActiveRecord::Migration
  def change
  	change_column_default(:days, :life_gained_lost, 0)
  	change_column_default(:days, :total_lgl, 0)
  end
end
