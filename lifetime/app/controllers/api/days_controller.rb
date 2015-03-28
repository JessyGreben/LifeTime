class Api::DaysController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @data = @user.days
    if request.xhr?
      render json: @data
    end
  end
end
