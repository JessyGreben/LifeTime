class Api::UsersController < ApplicationController
 

  def steps
  	"in route"
  	@user = User.find(params[:user_id])
    @user.days.last(14)

    def each_day_lgl(user_days)
      day_arr = []
      user_days.each do |day|
        mins = day.life_gained_lost / 60
        day_arr << mins
      end
      return day_arr.unshift("Day")
    end

  	@lgl = each_day_lgl(@user.days.last(14))

  	render json: @lgl
  end
end
