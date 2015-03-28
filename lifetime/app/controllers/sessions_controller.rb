class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @authorization = Authorization.where(provider: auth_hash["provider"] AND uid: auth_hash["uid"]).first
	  if @authorization
	  	@user = User.find(@authorization.user_id)
	    sessions[:id] = @user.id
	  else
	    # user = User.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"]
	    # user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	    # user.save

	    ###Update above info when we know what we're doing
	 
	    render :text => auth_hash.inspect
	  end

  end

  def failure
  end

  def destroy
  	session[:id] = nil
  	redirect_to root_path
    
  end
end
