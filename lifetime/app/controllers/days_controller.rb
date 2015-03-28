class DaysController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @data = @user.days
    # render json: {data: @data}
  end
end
