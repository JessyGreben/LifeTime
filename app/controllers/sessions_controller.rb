require 'jawbone'
require 'awesome_print'

class SessionsController < ApplicationController
  def new
  end

  def fitbit_create
    auth_hash = request.env['omniauth.auth']
    user_id = auth_hash['uid']
    ap auth_token = auth_hash['extra']['access_token']

    @auth_params = auth_token.params

    p @auth_params
    p user_id
    get_fitbit_trends(user_id)
  end

  def jawbone_create
    auth_hash = request.env['omniauth.auth']
    access_token = auth_hash["credentials"]["token"]
    get_jawbone_trends(access_token)
    @authorization = Authorization.where("uid = '#{auth_hash["uid"]}'").first
    if @authorization
      @user = User.find(@authorization.user_id)
      session[:id] = @user.id
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

  def get_jawbone_trends(access_token)
    p @trends_response = HTTParty.get("https://jawbone.com/nudge/api/v.1.1/users/@me/trends?num_buckets=100", :headers => { "Accept" => "application/json", "Host" => "jawbone.com", "Authorization" => "Bearer #{access_token}" })
    @weight = (@trends_response['data']['data'][0][1]['weight']).to_i
    @height = (@trends_response['data']['data'][0][1]['height']).to_f
    @age = (@trends_response['data']['data'][0][1]['age']).to_i
    @gender = (@trends_response['data']['data'][0][1]['gender'])
  end

  def get_fitbit_trends(uid)
    options = @auth_params
    ap @response = HTTParty.get("https://api.fitbit.com/1/user/user_id=24VZQG/activities/date/2015-04-12.json", options)
    # ?oauth_token=bc615fa7068824cb7d651aa36b05fd67
    # :headers => {"token" => "bc615fa7068824cb7d651aa36b05fd67", "secret" => "ece325fdd0ee20eaae0e57064901181e"
  end

  def destroy
  	session[:id] = nil
  	redirect_to root_path
  end

end

