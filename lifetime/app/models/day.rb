class Day < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  before_create :set_life_expectancy
  after_create :calculate_lgl, :calculate_life_expectancy 

  def set_life_expectancy
  	self.life_expectancy = 79
  end

  def calculate_lgl
  	todays_steps = self.activity.steps
  	if todays_steps < 3000
  		self.update_attributes(life_gained_lost: -4320) # 72 mins, 1.2hrs
  	elsif (todays_steps > 3000) && (todays_steps <10000)
  		self.update_attributes(life_gained_lost: 3499) #in seconds
  	else todays_steps >10000
  		self.update_attributes(life_gained_lost: 4921) #in seconds
  	end
  	calculate_total_lgl
  end

  def calculate_total_lgl
  	self.life_expectancy ||= 79
  	days_lgl_array = []
  	self.user.days.each do |day|
  		days_lgl_array << day.life_gained_lost
  	end
    total = days_lgl_array.reduce(:+)
  	self.update_attributes(total_lgl: total)
  end

  def calculate_life_expectancy
    total_lgl_in_seconds = self.total_lgl
    total_lgl_in_years = total_lgl_in_seconds / 31556926.0 #seconds in a year
    new_expectancy = self.life_expectancy + total_lgl_in_years
  	self.update_attributes(life_expectancy: new_expectancy)
  end

  def display_total_lgl(param=self.total_lgl, display_value=[])
    
    total = param.abs
    if total > 31556926.0
      divmod_arr = total.divmod(31556926.0)
      display_value << divmod_arr[0] << "years"
      x = divmod_arr[1]
      display_total_lgl(x, display_value)
    elsif total > 86400
      divmod_arr = total.divmod(86400.0)
      display_value << divmod_arr[0] << "days"
      x = divmod_arr[1]
      display_total_lgl(x, display_value)
    elsif total > 3600 
      divmod_arr = total.divmod(3600.0)
      display_value << divmod_arr[0] << "hours"
      x = divmod_arr[1]
      display_total_lgl(x, display_value)
    elsif total > 60 
      divmod_arr = total.divmod(60.0)
      display_value << divmod_arr[0] << "mins"
      x = divmod_arr[1]
      display_total_lgl(x, display_value) 
    else
      display_value << total << "secs"
    end

    display_value.unshift(display_pos_neg_lgl(3333)).join(' ')
  end

  def display_pos_neg_lgl(param=self.total_lgl)
    if param > 0 
      gain_lost = "+"
    else
      gain_lost = "-"
    end
    gain_lost
  end 




end
