require 'jawbone'
require 'awesome_print'

class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    access_token = auth_hash["credentials"]["token"]

    get_trends(access_token)

    @authorization = Authorization.where("uid = '#{auth_hash["uid"]}'").first

    if @authorization
      @user = User.find(@authorization.user_id)
      session[:id] = @user.id 
      # if @user.day.last.date != @trends_response['data']['data'][-1][0]
      #   logic 2015 03 26.split('') = [2,0,1,5,0,3,2,6]  

      # end

    else
      @user = User.create(:firstname => auth_hash["info"]["first_name"], :lastname => auth_hash["info"]["last_name"], :image => auth_hash["info"]["photo"], :age => @age, :weight_kgs => @weight, :height_meters => @height, :gender => @gender)
      Authorization.create(:provider => auth_hash["provider"], :uid => auth_hash["uid"],:access_token => auth_hash["credentials"]["token"], :refresh_token => auth_hash["credentials"]["refresh_token"], user_id: @user.id)
      
      
      @trends_response['data']['data'].each do |day_data|
        p steps = (day_data[1]['m_steps']).to_i
        user_activity = Activity.create(steps: steps)
        user_day = Day.create(user_id: @user.id, date: day_data[0], activity_id: user_activity.id)

      end
      session[:id] = @user.id

    end
    redirect_to "/users/#{@user.id}"

  end

  def get_trends(access_token)
    @trends_response = HTTParty.get("https://jawbone.com/nudge/api/v.1.1/users/@me/trends?num_buckets=100", :headers => { "Accept" => "application/json", "Host" => "jawbone.com", "Authorization" => "Bearer #{access_token}" })  
    @weight = (@trends_response['data']['data'][0][1]['weight']).to_i
    @height = (@trends_response['data']['data'][0][1]['height']).to_f
    @age = (@trends_response['data']['data'][0][1]['age']).to_i
    @gender = (@trends_response['data']['data'][0][1]['gender'])
  end


  # def failure
  # end

  # def destroy
  # 	session[:id] = nil
  # 	redirect_to root_path  
  # end

end

