class Day < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity, dependent: :destroy

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
    total_lgl_in_years = total_lgl_in_seconds / 31556926 #seconds in a year
    new_expectancy = self.life_expectancy + total_lgl_in_years
  	self.update_attributes(life_expectancy: new_expectancy)
  end

  def display_total_lgl(param=self.total_lgl, display_value=[])

    total = param.abs
    if total > 31556926
      get_next_time_value(get_divmod_array(total, 31556926), add_time_value_to_display(get_divmod_array(total, 31556926), 'years', display_value))
    elsif total > 86400
      get_next_time_value(get_divmod_array(total, 86400), add_time_value_to_display(get_divmod_array(total, 86400), 'days', display_value))
    elsif total > 3600
      get_next_time_value(get_divmod_array(total, 3600), add_time_value_to_display(get_divmod_array(total, 3600), 'hours', display_value))
    elsif total > 60
      get_next_time_value(get_divmod_array(total, 60), add_time_value_to_display(get_divmod_array(total, 60), 'mins', display_value))
    else
      display_value << total << "secs"
    end

    timer = display_value.join(' ')
    display_pos_neg + " " + timer
    # timer.display_pos_neg

  end

  def get_next_time_value(divmod_arr, display_value)
    display_total_lgl(divmod_arr[1], display_value)
  end

  def get_divmod_array(total, number)
    divmod_arr = total.divmod(number.to_f)
  end

  def add_time_value_to_display(divmod_arr, time_unit, display_value)
    display_value << divmod_arr[0] << time_unit
  end

  def display_pos_neg(param=self.total_lgl)
    if param > 0
      gain_lost = "+"
    else
      gain_lost = "-"
    end
    gain_lost
  end

  def display_life_expectancy
    self.user.days.last.life_expectancy.to_s + "years"
  end

end
