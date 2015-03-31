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
		 p uid = @user.authorization.uid
		 # DZKhP1GKIZJoh9WWNgaYDA

		p @graph_response = HTTParty.get("https://jawbone.com/nudge/api/v.1.1/workouts/#{uid}/image", :headers => { "Authorization" => "#{access_token}" })  

		@graph_response.to_json

	end

end
