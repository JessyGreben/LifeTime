class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    p refresh_token = auth_hash["credentials"]["refresh_token"]
    p token = auth_hash["credentials"]["token"]

    p first_name = auth_hash["info"]["first_name"]
    p last_name = auth_hash["info"]["last_name"]
    p last_name = auth_hash["info"]["photo"]  #returns a jpeg
    p provider = auth_hash["provider"]
    p uid = auth_hash["uid"]

    p code = auth_hash[
    p auth_hash

    # @result = HTTParty.post("https://jawbone.com/auth/oauth2/token?grant_type=authorization_code&client_id=o4Hz7i2NVsw&client_secret=6574706ac3ec1456f97ebd6f5af51de7e8df711c&code=mGKV_178jYyG7R7zX-mOdzFgyTmy-xwRX-2u4kQEkCV0QaeLBfiEgN0Z0mWVMTbFANA90H2Oo1al19znQ-7Xk8ZEG9MffL2b6ZJxVteWY4OGHTTJRkXyBAmhC-Ase2OQJfXm-1Nxg7KnFpAnVUcWgo5ggA1fmIbeIjTa3y_arXL-q55Nwa-HRSgqUJ51op6z5PJTR5thIV1HzWqCRKaa-A")



    # @authorization = Authorization.where(provider: auth_hash["provider"] AND uid: auth_hash["uid"]).first
 
    # if @authorization
    #   @user = User.find(@authorization.user_id)
    #   sessions[:id] = @user.id
    # else
     # user = User.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"]
     # user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
     # user.save

     ###Update above info when we know what we're doing
 
   # render :text => @result.inspect
  # end

  end

  def failure
  end

  def destroy
  	session[:id] = nil
  	redirect_to root_path
    
  end
end
