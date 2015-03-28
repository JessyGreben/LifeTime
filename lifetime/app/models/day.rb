class Day < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  # before_save :calculate_life_expectancy, :calculate_lgl, :calculate_sum_lgl, 

  # def calculate_life_expectancy
  # end

  # def calculate_lgl
  # end

  # def calculate_sum_lgl
  # end
end
