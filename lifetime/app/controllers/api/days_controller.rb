class Api::DaysController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @data = @user.days
    @steps = @user.activities
    # if request.xhr?
      render json: {data: @data, steps: @steps}
    # end
  end
end
