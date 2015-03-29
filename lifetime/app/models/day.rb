class Day < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  before_create :set_life_expectancy
  before_save :calculate_life_expectancy, :calculate_lgl, :calculate_total_lgl 

  def set_life_expectancy
  	self.life_expectancy = 79
  end

  def calculate_life_expectancy
  	self.life_expectancy + self.total_lgl
  end

  def calculate_lgl
  	todays_steps = self.activity.steps
  	if todays_steps < 3000
  		self.life_gained_lost = -4320 # 72 mins, 1.2hrs
  	elsif (todays_steps > 3000) && (todays_steps <10000)
  		self.life_gained_lost = 3499 #in seconds
  	else todays_steps >10000
  		self.life_gained_lost = 4921 #in seconds
  	end
  end

  def calculate_total_lgl
  	self.life_expectancy ||= 79
  	days_lgl_array = []
  	self.user.days.each do |day|
  		days_lgl_array << day.life_gained_lost
  	end
  	days_lgl_array.reduce(:+)
  end
end
