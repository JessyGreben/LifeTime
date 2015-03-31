class Api::DaysController < ApplicationController
  def index
    user = User.find(params[:user_id])
    year = user.days.last(360)
    year_average = calc_life_gained_lost(year)
    months = []
    month = year.each_slice(30) {|month| months << month}
    month_average = calc_life_gained_lost(months)
    steps = user.activities
    # if request.xhr?
    render json: calendar_output(year_average, months)
    # end
  end

  def calc_life_gained_lost(days_array)
    sum = 0
    days_array.each do |day|
      sum += day.life_gained_lost
    end
    sum / days_array.length
  end

  def get_color(life_gained_lost)
    []
  end
end

# format [ {name: "Year 1", children: [{ name: "Month 1", children: [{name: "Day 1", colour:"green"}]}]]
def calendar_output(year_average, months)
  output = {year: year_average, children: {}}
  months.each_with_index do |month, index|
    output[:children]["month_#{index}".to_sym] = calc_life_gained_lost(month)
    month.each_with_index do |day, day_index|
      output[:children]["month_#{index}".to_sym][:children]["day_#{day_index}".to_sym] = day.life_gained_lost
    end
  end
  output
end
