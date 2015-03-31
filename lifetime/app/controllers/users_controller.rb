class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

	def index
    # @user = User.find(session[:id])
	end

	def graphs
		 @user = User.find(params[:user_id])
		 access_token = @user.authorization.access_token
		 uid = @user.authorization.uid

		p @graph_response = HTTParty.get("https://jawbone.com/nudge/api/v.1.1/workouts/40F7_htRRnT8Vo7nRBZO1X/image", :headers => { "Accept" => "application/json", "Host" => "jawbone.com", "Authorization" => "Bearer #{access_token}" })  

		@graph_response.to_json

	end

end
