require 'jawbone'
require 'awesome_print'

class SessionsController < ApplicationController
  def new
  end

  def create
    p auth_hash = request.env['omniauth.auth']
    access_token = auth_hash["credentials"]["token"]

    @authorization = Authorization.where("uid = '#{auth_hash["uid"]}'").first

    if @authorization
      @user = User.find(@authorization.user_id)
      session[:id] = @user.id 
      
      redirect_to "/users/1"

    else
      get_trends(access_token)
      @user = User.create(:firstname => auth_hash["info"]["first_name"], :lastname => auth_hash["info"]["last_name"], :image => auth_hash["info"]["photo"], :age => @age, :weight_kgs => @weight, :height_meters => @height, :gender => @gender)
      Authorization.create(:provider => auth_hash["provider"], :uid => auth_hash["uid"],:access_token => auth_hash["credentials"]["token"], :refresh_token => auth_hash["credentials"]["refresh_token"], user_id: @user.id)
      
      
      @trends_response['data']['data'].each do |day_data|
        p "im in the loop"
        p steps = (day_data[1]['m_steps']).to_i
        p day_data[1]['m_steps']
        user_activity = Activity.create(steps: steps)

        user_day = Day.create(user_id: @user.id, date: day_data[0], activity_id: user_activity.id)

        # user_day = @user.day.build date: day_data[0]
        # user_day.activity.build steps: day_data[1]['m_steps']
        # user_day.save
        # p user_day
      end
      # raise 'meow'
      
      session[:id] = @user.id
    end
     
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
# def trends(params={})
#       get_helper("users/@me/trends", params)
#     end

# def get_helper(path, params={})
  #     path = "/" + path unless path[0] == '/'
  #     url = BASE_URL + path
  #     stringified_params = params.collect do |k, v|
  #       "#{k}=#{v}"
  #     end.sort * '&'
  #     full_url = url + "?" + stringified_params
  #     response = self.class.get full_url,
  #       { :headers => { "Authorization" => "Bearer #{token}" } }
  #     response.parsed_response
  #   end
