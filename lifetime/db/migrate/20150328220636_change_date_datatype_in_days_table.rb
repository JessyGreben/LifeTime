class ChangeDateDatatypeInDaysTable < ActiveRecord::Migration
  def up
  	change_column :days, :date, :string
  end

  def down
  	change_column :days, :date, :datetime
  end
end
